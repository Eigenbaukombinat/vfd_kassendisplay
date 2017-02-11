/*--------------------------------------------------
Telnet to Serial AccessPoint for ESP8266 
for ESP8266 adapted Arduino IDE

by Stefan Thesen 08/2015 - free for anyone
http://blog.thesen.eu

Creates an accesspoint or network client which can 
be connected by telnet; e.g. telnet 192.168.4.1
Telnet input is sent to serial and vice versa.

Serial output can e.g. be used to steer an attached
Arduino or other serial interfaces.
Please take care for levels of the serial lines.

Code inspired by a post of ghost on github:
https://github.com/esp8266/Arduino/issues/307
--------------------------------------------------*/

#include <ESP8266WiFi.h>

////////////////////////////////////
// settings for Telnet2Serial Bridge
////////////////////////////////////

// max number of clients that can connect
#define MAX_NO_CLIENTS 5
const WiFiMode wifi_mode = WIFI_STA;     // set WIFI_AP for access-point or WIFI_STA for WIFI client
const char* ssid = "Eigenbaukombinat";   // Name of AP (for WIFI_AP) or name of Wifi to connect to (for WIFI_STA)
const char* password = "xxxxxx";      // set to "" for open access point w/o password
const int iSerialSpeed = 9600;          // speed of the serial connection
const bool bSuppressLocalEcho = true;   // shall local echo in telnet be suppressed (usually yes)



// Create an instance of the server on Port 23
WiFiServer server(23);
WiFiClient pClientList[MAX_NO_CLIENTS]; 

void setup() 
{
  // start serial
  Serial.begin(iSerialSpeed);

  if (wifi_mode == WIFI_AP)
  {
    // AP mode
    WiFi.mode(wifi_mode);
    WiFi.softAP(ssid, password);
    server.begin();
    server.setNoDelay(true);
  }
  else
  {
    // network cient - inital connect
    WiFi.mode(WIFI_STA);
    WiFiStart();
  }
}


void WiFiStart()
{ 
  // Connect to WiFi network
  WiFi.begin(ssid, password);
  
  while (WiFi.status() != WL_CONNECTED) 
  {
    delay(500);
  }
  
  // Start the server
  server.begin();
  server.setNoDelay(true);
}


void loop() 
{ 
  int ii;

  ////////////////////////////////////////////////
  // if network client: check if WLAN is connected
  ////////////////////////////////////////////////
  if ((wifi_mode == WIFI_STA) && (WiFi.status() != WL_CONNECTED))
  {
    WiFiStart();
  }

  /////////////////////
  // handle new clients
  /////////////////////
  if (server.hasClient())
  {
    bool bFoundPlace=false;
    
    // search a free spot
    for(ii = 0; ii < MAX_NO_CLIENTS; ii++)
    {
      if (!pClientList[ii] || !pClientList[ii].connected())
      {
        // remove old connections
        if(pClientList[ii]) 
        {
          pClientList[ii].stop();
        }

        // new client
        pClientList[ii] = server.available();
        if (bSuppressLocalEcho) 
        { 
          pClientList[ii].write("\xFF\xFB\x01", 3); 
        }
        pClientList[ii].write("Welcome to Telnet2Serial Adapter - S. Thesen 08/2015 - https://blog.thesen.eu\r\n"); 
        bFoundPlace=true;
        break;
      }
    }

    //no free spot --> sorry
    if (!bFoundPlace)
    {
      WiFiClient client = server.available();
      client.stop();
    }
  }

  /////////////////////
  // Telnet --> Serial
  /////////////////////
  for(ii = 0; ii < MAX_NO_CLIENTS; ii++)
  {
    if (pClientList[ii] && pClientList[ii].connected())
    {
      if(pClientList[ii].available())
      {
        while(pClientList[ii].available()) 
        {
          Serial.write(pClientList[ii].read());
        }
      }
    }
  }

  /////////////////////
  // Serial --> Telnet
  /////////////////////
  if(Serial.available())
  {
    size_t len = Serial.available();
    uint8_t sbuf[len];
    Serial.readBytes(sbuf, len);

    for(ii = 0; ii < MAX_NO_CLIENTS; ii++)
    {
      if (pClientList[ii] && pClientList[ii].connected())
      {
        pClientList[ii].write(sbuf, len);
        delay(1);
      }
    }
  }

}
