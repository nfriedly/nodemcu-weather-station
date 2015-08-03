# NodeMCU Weather Station
Displays current weather conditions inside and out. Built on top of [NodeMCU](https://github.com/nodemcu/nodemcu-firmware)

Current version displays inside and outside temperature and humidity, current weather, and barometric pressure. This is a rough draft of what I have in mind, the final version will have a second module outside collecting data rather than fetching from yahoo weather (but it will probably call yahoo for the forecast instead).

![prototype](https://raw.githubusercontent.com/nfriedly/nodemcu-weather-station/master/media/prototpe-1.jpg)

## Current parts list:
* [ESP-12E w/ adapter board](http://www.electrodragon.com/product/esp8266-smd-adapter-board/) +  [Programmer](http://www.electrodragon.com/product/cp2102-usb-ttl-uart-module-v2/) + [M/F wires](http://www.electrodragon.com/product/prototype-cable-female-and-male-end-40p/)
  * Alternatively, a [NodeMCU dev kit](http://www.electrodragon.com/product/nodemcu-lua-amica-r2-esp8266-wifi-board/) could replace all three of these
* [128x64 i2c OLED](http://www.electrodragon.com/product/0-96-12864-oled-display-iicspi/)
* [DHT11 Temp/Humidity sensor](http://www.electrodragon.com/product/humidity-and-temperature-sensor-dht11/)
* [BMP180 Temp/Pressure sensor](http://www.electrodragon.com/product/bmp180-barometric-pressure-sensor-board/)
* [Breadboard](http://www.electrodragon.com/product/breadboard-wside-power-channels/),  [wires](http://www.electrodragon.com/product/jumper-wire-60-70-pcs/)

Total cost: ~$25-30 w/ shipping

## Instructions

1. Assemble everything as shown (sorry I don't have a better diagram yet). 
2. Put your wifi info and woeid into the config.lua.
3. Upload the firmare with [esptool](https://github.com/themadinventor/esptool/) (the repo includes a [custom build](http://frightanic.com/nodemcu-custom-build/) with extra fonts)
4. Upload and compile all .lua scripts with [Esplorer](http://esp8266.ru/esplorer/)
5. Enjoy!

## Planned Changes

I'll probably drop the current sensors in favor of a [DHT22](http://www.electrodragon.com/product/dht22-pre-order-link/) (for higher accuracy),  and maybe choose a different display. I might also grab different ESP modules, probably an  [ESP-01](http://www.electrodragon.com/product/esp8266-wi07c-wifi-module/) for the outside part. I may also have it upload data to a server somewhere for pretty graphs. I still need to figure out power...


## MIT License

The MIT License (MIT)

Copyright (c) 2015 Nathan Friedly - http://nfriedly.com/

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

