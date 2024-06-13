# smart assistant

# Actual Final Product
In the actual project if deployed in real world, we would need a central server which would be a raspberry pi, with hotspot setup, and nice specifications. And then, each patient room would have another raspberry pi device, which would be connected to the server through wifi. The requests that the patient sends would be sent as requests to the central server, and then a response would be received, which would be converted to audio and played to the patient. In case the central server detect that it's not possible to answer the query, it would send a SOS alert to the nurses phone. FYI, the nurses phones would be also connected to the central server but on a different route, so it'll listen to the server continuously and release a notification if there's any change.

# MVP
Since we only have one raspberry for now, what we can do is, we can assume that right now there's only one patient. So, the same device would act as the central server and the device to be kept in patients room. It would have hotspot, and the phones of the nurses would be connected to it. The device would listen to the commands by the patient, run them through the nlp program, and then return the response as audio. If the server feels that it is unable to answer the query, it would send a notification to the nurses devices, and tell the patient that a nurse is arriving soon.

# Steps
Create dummy json data of patients
create flask project flow
train nlp model / or try chatgpt apis
send a webhook notification
flutter app setup - ui, push notifications, etc 
configure raspberry pi with the flask project

# Demo Video
https://youtu.be/d8QeST91W4A
