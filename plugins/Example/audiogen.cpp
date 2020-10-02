/****************************************************************************
  **
  ** Copyright (C) 2015 The Qt Company Ltd.
  ** Contact: http://www.qt.io/licensing/
  **
  ** This file is part of the examples of the Qt Toolkit.
  **
  ** $QT_BEGIN_LICENSE:BSD$
  ** You may use this file under the terms of the BSD license as follows:
  **
  ** "Redistribution and use in source and binary forms, with or without
  ** modification, are permitted provided that the following conditions are
  ** met:
  **   * Redistributions of source code must retain the above copyright
  **     notice, this list of conditions and the following disclaimer.
  **   * Redistributions in binary form must reproduce the above copyright
  **     notice, this list of conditions and the following disclaimer in
  **     the documentation and/or other materials provided with the
  **     distribution.
  **   * Neither the name of The Qt Company Ltd nor the names of its
  **     contributors may be used to endorse or promote products derived
  **     from this software without specific prior written permission.
  **
  **
  ** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  ** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  ** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  ** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  ** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  ** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  ** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  ** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  ** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  ** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  ** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
  **
  ** $QT_END_LICENSE$
  **
  ****************************************************************************/

#include <QAudioDeviceInfo>
#include <QAudioOutput>
#include <QAudioInput>
#include <QTimer>
#include <QDebug>
#include <qmath.h>
#include <qendian.h>
//#include <QVBoxLayout> // no

#include "audiogen.h"

#define PUSH_MODE_LABEL "Enable push mode"
#define PULL_MODE_LABEL "Enable pull mode"
#define SUSPEND_LABEL   "Suspend playback"
#define RESUME_LABEL    "Resume playback"
#define VOLUME_LABEL    "Volume:"

const int DurationSeconds = 1;
const int DataSampleRateHz = 44100;
const int BufferSize      = 32768;
//int ToneSampleRateHz = 500;

Generator::Generator(const QAudioFormat &format, qint64 durationUs, int sampleRate, QObject *parent)
      :   QIODevice(parent)
      ,   m_pos(0)
{
      if (format.isValid())
          generateData(format, durationUs, sampleRate);
}

Generator::~Generator() {
      //
}

void Generator::start() {
      open(QIODevice::ReadOnly);
}

void Generator::stop() {
      m_pos = 0;
      close();
}

void Generator::generateData(const QAudioFormat &format, qint64 durationUs, int sampleRate) {
      const int channelBytes = format.sampleSize() / 8;
      const int sampleBytes = format.channelCount() * channelBytes;

      qint64 length = (format.sampleRate() * format.channelCount() * (format.sampleSize() / 8))
                          * durationUs / 100000;

      Q_ASSERT(length % sampleBytes == 0);
      Q_UNUSED(sampleBytes) // suppress warning in release builds

      m_buffer.resize(length);
      unsigned char *ptr = reinterpret_cast<unsigned char *>(m_buffer.data());
      int sampleIndex = 0;

      while (length) {
          const qreal x = qSin(2 * M_PI * sampleRate * qreal(sampleIndex % format.sampleRate()) / format.sampleRate());
          for (int i=0; i<format.channelCount(); ++i) {
              if (format.sampleSize() == 8 && format.sampleType() == QAudioFormat::UnSignedInt) {
                  const quint8 value = static_cast<quint8>((1.0 + x) / 2 * 255);
                  *reinterpret_cast<quint8*>(ptr) = value;
              } else if (format.sampleSize() == 8 && format.sampleType() == QAudioFormat::SignedInt) {
                  const qint8 value = static_cast<qint8>(x * 127);
                  *reinterpret_cast<quint8*>(ptr) = value;
              } else if (format.sampleSize() == 16 && format.sampleType() == QAudioFormat::UnSignedInt) {
                  quint16 value = static_cast<quint16>((1.0 + x) / 2 * 65535);
                  if (format.byteOrder() == QAudioFormat::LittleEndian)
                      qToLittleEndian<quint16>(value, ptr);
                  else
                      qToBigEndian<quint16>(value, ptr);
              } else if (format.sampleSize() == 16 && format.sampleType() == QAudioFormat::SignedInt) {
                  qint16 value = static_cast<qint16>(x * 32767);
                  if (format.byteOrder() == QAudioFormat::LittleEndian)
                      qToLittleEndian<qint16>(value, ptr);
                  else
                      qToBigEndian<qint16>(value, ptr);
              }

              ptr += channelBytes;
              length -= channelBytes;
          }
          ++sampleIndex;
      }
}

qint64 Generator::readData(char *data, qint64 len) {
      qint64 total = 0;
      if (!m_buffer.isEmpty()) {
          while (len - total > 0) {
              const qint64 chunk = qMin((m_buffer.size() - m_pos), len - total);
              memcpy(data + total, m_buffer.constData() + m_pos, chunk);
              m_pos = (m_pos + chunk) % m_buffer.size();
              total += chunk;
          }
      }
      return total;
}

qint64 Generator::writeData(const char *data, qint64 len) {
      Q_UNUSED(data);
      Q_UNUSED(len);

      return 0;
}

qint64 Generator::bytesAvailable() const {
      return m_buffer.size() + QIODevice::bytesAvailable();
}

AudioGenTest::AudioGenTest()
      :   m_pushTimer(new QTimer(this))
      //,   m_modeButton(0)
      //,   m_suspendResumeButton(0)
      //,   m_deviceBox(0)
      ,   m_deviceInfo(QAudioDeviceInfo::defaultOutputDevice())
      ,   m_deviceInfoIn(QAudioDeviceInfo::defaultInputDevice())
      ,   m_generator(0)
      ,   m_audioOutput(0)
      ,   m_audioInput(0)
      ,   m_outputDevice(0)
      ,   m_pullMode(false)
      ,   m_buffer(BufferSize, 0)
      ,   ToneSampleRateHz(200)
      ,   destinationFile(0)
{
      //initializeWindow(); // THIS TO GO
      //initializeAudio();
}

// THIS TO GO
/*
void AudioTest::initializeWindow() {
      QScopedPointer<QWidget> window(new QWidget);
      QScopedPointer<ColumnLayout> layout(new ColumnLayout);

      m_deviceBox = new QComboBox(this);
      const QAudioDeviceInfo &defaultDeviceInfo = QAudioDeviceInfo::defaultOutputDevice();
      m_deviceBox->addItem(defaultDeviceInfo.deviceName(), qVariantFromValue(defaultDeviceInfo));
      foreach (const QAudioDeviceInfo &deviceInfo, QAudioDeviceInfo::availableDevices(QAudio::AudioOutput)) {
          if (deviceInfo != defaultDeviceInfo)
              m_deviceBox->addItem(deviceInfo.deviceName(), qVariantFromValue(deviceInfo));
      }
      connect(m_deviceBox,SIGNAL(activated(int)),SLOT(deviceChanged(int)));
      layout->addWidget(m_deviceBox);

      m_modeButton = new QPushButton(this);
      m_modeButton->setText(tr(PUSH_MODE_LABEL));
      connect(m_modeButton, SIGNAL(clicked()), SLOT(toggleMode()));
      layout->addWidget(m_modeButton);

      m_suspendResumeButton = new QPushButton(this);
      m_suspendResumeButton->setText(tr(SUSPEND_LABEL));
      connect(m_suspendResumeButton, SIGNAL(clicked()), SLOT(toggleSuspendResume()));
      layout->addWidget(m_suspendResumeButton);

      QHBoxLayout *volumeBox = new QHBoxLayout;
      m_volumeLabel = new QLabel;
      m_volumeLabel->setText(tr(VOLUME_LABEL));
      m_volumeSlider = new QSlider(Qt::Horizontal);
      m_volumeSlider->setMinimum(0);
      m_volumeSlider->setMaximum(100);
      m_volumeSlider->setSingleStep(10);
      connect(m_volumeSlider, SIGNAL(valueChanged(int)), this, SLOT(volumeChanged(int)));
      volumeBox->addWidget(m_volumeLabel);
      volumeBox->addWidget(m_volumeSlider);
      layout->addLayout(volumeBox);

      window->setLayout(layout.data());
      layout.take(); // ownership transferred

      setCentralWidget(window.data());
      QWidget *const windowPtr = window.take(); // ownership transferred
      windowPtr->show();
}
*/

void AudioGenTest::initializeAudio() {
      connect(m_pushTimer, SIGNAL(timeout()), SLOT(pushTimerExpired()));
      qDebug() << "init - connect";
      m_formatOut.setSampleRate(DataSampleRateHz);
      m_formatOut.setChannelCount(1);
      m_formatOut.setSampleSize(16);
      m_formatOut.setCodec("audio/pcm");
      m_formatOut.setByteOrder(QAudioFormat::LittleEndian);
      m_formatOut.setSampleType(QAudioFormat::SignedInt);
      qDebug() << "init - mformat.";
      QAudioDeviceInfo info(m_deviceInfo);
      if (!info.isFormatSupported(m_formatOut)) {
          qWarning() << "Default format not supported - trying to use nearest";
          m_formatOut = info.nearestFormat(m_formatOut);
      }
      qDebug() << "init - device info.";
      if (m_generator)
          delete m_generator;
      // here be the freq: ToneSampleRateHz
      m_generator = new Generator(m_formatOut, DurationSeconds*1000000, ToneSampleRateHz, this);
      qDebug() << "init - mgenerator.";
      createAudioOutput();
}

void AudioGenTest::createAudioOutput() {
      delete m_audioOutput;
      m_audioOutput = 0;
      m_audioOutput = new QAudioOutput(m_deviceInfo, m_formatOut, this);
      volumeChanged(50);
      m_generator->start();
      m_audioOutput->start(m_generator);
      //m_volumeSlider->setValue(int(m_audioOutput->volume()*100.0f));
}

AudioGenTest::~AudioGenTest() {
      //
}

void AudioGenTest::deviceChanged(int index) {
      m_pushTimer->stop();
      m_generator->stop();
      m_audioOutput->stop();
      m_audioOutput->disconnect(this);
      //m_device = m_deviceBox->itemData(index).value<QAudioDeviceInfo>();
      m_deviceInfo = m_deviceInfo;
      initializeAudio();
}

void AudioGenTest::volumeChanged(int value) {
      if (m_audioOutput)
          m_audioOutput->setVolume(qreal(value/100.0f));
}

void AudioGenTest::pushTimerExpired() {
      if (m_audioOutput && m_audioOutput->state() != QAudio::StoppedState) {
          int chunks = m_audioOutput->bytesFree()/m_audioOutput->periodSize();
          while (chunks) {
             const qint64 len = m_generator->read(m_buffer.data(), m_audioOutput->periodSize());
             if (len)
                 m_outputDevice->write(m_buffer.data(), len);
             if (len != m_audioOutput->periodSize())
                 break;
             --chunks;
          }
      }
}

void AudioGenTest::toggleMode() {
      m_pushTimer->stop();
      m_audioOutput->stop();

      // default is true
      if (m_pullMode) {
          //switch to push mode (periodically push to QAudioOutput using a timer)
          //m_modeButton->setText(tr(PULL_MODE_LABEL));
          m_outputDevice = m_audioOutput->start();
          m_pullMode = false;
          m_pushTimer->start(20);
      }
      else {
          //switch to pull mode (QAudioOutput pulls from Generator as needed)
          //m_modeButton->setText(tr(PUSH_MODE_LABEL));
          m_pullMode = true;
          m_audioOutput->start(m_generator);
      }
      //m_suspendResumeButton->setText(tr(SUSPEND_LABEL));
  }

void AudioGenTest::toggleSuspendResume() {
      qDebug() << "toggle AudioGen called.";
      if (m_audioOutput != 0) {
          if (m_audioOutput->state() == QAudio::SuspendedState) {
              m_audioOutput->resume();
              //m_suspendResumeButton->setText(tr(SUSPEND_LABEL));
          }
          else if (m_audioOutput->state() == QAudio::ActiveState) {
              m_audioOutput->suspend();
              //m_suspendResumeButton->setText(tr(RESUME_LABEL));
          }
          else if (m_audioOutput->state() == QAudio::StoppedState) {
              m_audioOutput->resume();
              //m_suspendResumeButton->setText(tr(SUSPEND_LABEL));
          }
          else if (m_audioOutput->state() == QAudio::IdleState) {
              // no-op
          }
      }
      else {
          qDebug() << "toggleSuspendResume called before init.";
      }
}

void AudioGenTest::runAudioGenTest() {
    qDebug() << "runAudioGenTest called.";
    // check for already running, do not allow multiple instances
    // or we can get harmonic distortion, pain etc etc
    if (m_audioOutput != 0) {
        qDebug() << "AudioGen already running.";
        // stop it, and reset for possible change in vars
        m_pushTimer->stop();
        m_audioOutput->stop();
        // add some Hz to check
        ToneSampleRateHz += 100;
        delete m_audioOutput;
        m_audioOutput = 0;
        qDebug() << "End of AudioGen running reset.";
    }
    else {
        qDebug() << "init Audio from runAudioGenTest.";
        initializeAudio();
        //volumeChanged(35); // set volume to lower half (value / 100 == 0 - 1)
    }
}

int AudioGenTest::getCurrentToneFreq() {
    return ToneSampleRateHz;
}

void AudioGenTest::testAudioInput() {
    qDebug() << "testAudioInput...";

    destinationFile.setFileName("/tmp/test.raw");
    destinationFile.open( QIODevice::WriteOnly | QIODevice::Truncate );
    qDebug() << "Set file complete. set formatIn";

    // then init the m_formatIn
    m_formatIn.setSampleRate(8000); // low to test
    m_formatIn.setChannelCount(1); // mic is mono
    m_formatIn.setSampleSize(16);
    m_formatIn.setSampleType(QAudioFormat::SignedInt);
    m_formatIn.setByteOrder(QAudioFormat::LittleEndian);
    m_formatIn.setCodec("audio/pcm");

    QAudioDeviceInfo info(m_deviceInfoIn);
    if (!info.isFormatSupported(m_formatIn)) {
        qWarning() << "Default format not supported - trying to use nearest";
        m_formatIn = info.nearestFormat(m_formatIn);
    }
    qDebug() << "init - device info.";

    m_audioInput = new QAudioInput(m_deviceInfoIn, m_formatIn, this);
    qDebug() << "end testAudioInput call state: " << m_audioInput->state();

    // test record for 3000ms
    // currently stuck with a : "Stream error: Access denied"
    QTimer::singleShot(3000, this, SLOT(stopRecording()));
    //m_audioInput->start(&destinationFile);
    m_audioInput->start();
}

void AudioGenTest::stopRecording() {
    m_audioInput->stop();
    destinationFile.close();
    qDebug() << "stopRecording called.";
    //delete m_audioInput;
}
