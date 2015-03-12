----------------------------------------------
--  Nexys4 User Demo ISE Project            --
----------------------------------------------
Copyright 2014, Digilent Inc.

******************
***  OVERVIEW  ***
******************

  The project represents the User Demo found on the Nexys4 configuration and demonstrates 
usage of the VGA display in 1280 X 1024 mode, the Artix7 XADC, the Nexys4 onboard ADT7420 
Temperature Sensor on Two-Wire Interface, the ADXL362 Accelerometer on SPI Interface, 
the PS2 interface, the RGB Leds, the ADMP421 Omnidirectional Microphone, Audio Output, 
the 16MB PSRAM Memory, user buttons, switches and LEDs.

  The project was created under ISE 14.7.

  The behavior is as follows:

  The project connects to the VGA display in a 1280*1024 resolution and displays various
  items on the screen:

    - a Digilent / Analog Devices logo

    - a mouse cursor, if a Usb mouse is connected to the board when the project is started

    - the audio signal from the onboard ADMP421 Omnidirectional Microphone

    - a small square representing the X and Y acceleration data from the ADXL362 onboard Accelerometer.
      The square moves according the Nexys4 board position. Note that the X and Y axes 
      on the board are exchanged due to the accelerometer layout on the Nexys4 board.
      The accelerometer display also displays the acceleration magnitude, calculated as
      SQRT( X^2 + Y^2 +Z^2), where X, Y and Z represent the acceleration value on the respective axes

    - The FPGA temperature, the onboard ADT7420 temperature sensor temperature value and the accelerometer
      temperature value

    - The value of the R, G and B components sent to the RGB Leds LD16 and LD17

   Other features:

    - The 16 Switches (SW0..SW15) are connected to LD0..LD15 except when audio recording is done

    - Pressing BTNL, BTNC and BTNR will toggle between Red, Green and Blue colors on LD16 and LD17
      Color sweeping returns when BTND is pressed. BTND also togles between LD16, LD17, none or both

    - Pressing BTNU will start audio recording for about 5S, then the audio data will be played back
      on the Audio output. While recording, LD15..LD0 will show a progressbar moving to left, while
      playing back, LD15..LD0 will show a progressbar moving to right. Recorded audio data is stored in
      the onboard Cellular RAM. 


  The .\source\source_files folder contains the .vhd, .ngc and .xco source files. A new ISE project can be created,
with the target component Artix 7 XC7A100T-1-csg324. Note that when a new ISE project is created, the Square_Root 
and PxlClkGen cores will have to be regenerated.

  Note that this project is very similar to the demo that is loaded into the QSPI Flash at the factory, but does 
contain a few minor differences. The primary difference is that the project that ships loaded in the QSPI Flash was 
built in Xilinx EDK, which requires a paid license. This design was ported to ISE so that free webpack users could 
also take advantage of the source code. In doing this, the initial hardware tests had to be removed from the design. 
To restore the QSPI with the original demo loaded into the Nexys4, use iMPACT or Vivado to program it with the 
file titled "nexys4userdemo_original.mcs" located in the binary folder. The tool will ask which flash device you
are targeting, which on the Nexys4 is a S25FL128S. 


********************
*** KNOWN ISSUES ***
********************

  - The accelerometer's temperature sensor does not provide an accurate absolute temperature reading, but does accurately
    measure changes in temperature. It is possible to compensate for the offset between the reported temperature and the
    actual temperature, but this demo does not do this, because the offset is different for every Nexys4. This means the 
    temperature display for the accelerometer reports an inaccurate temperature value.

  - Certain mice will not work with this demo. This has to do with their initialization requirements. Currently the 
    only work around for this is to try to use a different mouse.

