# import speech_recognition as sr
# import pyttsx3
# import requests
# import json
# import google.generativeai as genai

# # Initialize Text-to-Speech engine
# engine = pyttsx3.init()

# # Initialize Speech Recognition
# recognizer = sr.Recognizer()

# #congfiguration of gemini api 
# gemini_api_key = "AIzaSyCevIBWjGD3ByxwMfItNL3vmWhKFw-J0u8"
# genai.configure(api_key=gemini_api_key)
# model = genai.GenerativeModel('gemini-pro')

# # Function to speak the response
# def speak(text):
#     engine.say(text)
#     engine.runAndWait()

# # Function to recognize speech
# def listen():
#     with sr.Microphone() as source:
#         print("Listening...")
#         recognizer.adjust_for_ambient_noise(source)
#         audio = recognizer.listen(source)

#     try:
#         query = recognizer.recognize_google(audio).lower()
#         print("User Query:", query)
#         return query
#     except sr.UnknownValueError:
#         speak("Sorry, I couldn't understand what you said.")
#         listen()
#         return ""
#     except sr.RequestError as e:
#         print("Request to Google Speech Recognition service failed; {0}".format(e))
#         return ""



# #gemini data function to generate response 
# def get_gemini_data(query):
#     response = model.generate_content(query + 'in 20 words')
#     response_text=response.text
#     return response_text
    
    
        

# # # # Example usage
# # query = "What is fever."
# # text = get_gemini_data(query)
# # print(text)


# # Main function
# def main():
#     speak("Welcome to SHRA, Say help for assistant or emergency to connect to nurse")
#     wakeup = listen()
#     if "help" in wakeup:
#          speak("Hello! How can I assist you today?")
#          while True:
#              user_query = listen()
#              if user_query == "exit":
#                  speak("Hope I helped you today take care, get well soon!")
#                  break
#              elif user_query:
#                  gemini_data = get_gemini_data(user_query)
#                  response_text = "Here is what you should do now" + gemini_data
#                  speak(response_text)
#                  speak('If you want to end assistant say exit')
#     elif wakeup == "emergency":
#         speak("Connecting to nearest available nurse")
    
#     else:
#         speak("You are doing great, I dont think you need my assistant takecare bye!!")

   

# if __name__ == "__main__":
#     main()





import socket
import speech_recognition as sr
import pyttsx3
import requests
import json
import google.generativeai as genai

# Initialize Text-to-Speech engine
engine = pyttsx3.init()

# Initialize Speech Recognition
recognizer = sr.Recognizer()

#congfiguration of gemini api 
gemini_api_key = "AIzaSyCevIBWjGD3ByxwMfItNL3vmWhKFw-J0u8"
genai.configure(api_key=gemini_api_key)
model = genai.GenerativeModel('gemini-pro')



def get_ip_address():
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)
    return ip_address

# Function to speak the response
def speak(text):
    print("SHRA : " + text)
    engine.say(text)
    engine.runAndWait()

# Function to recognize speech
def listen():
    recognizer = sr.Recognizer()
    with sr.Microphone() as source:
        print("Listening...")
        recognizer.adjust_for_ambient_noise(source)
        audio = recognizer.listen(source)

    try:
        query = recognizer.recognize_google(audio).lower()
        print("User Query:", query)
        return query
    except sr.UnknownValueError:
        speak("Sorry, I couldn't understand what you said.")
        listen()
        return ""
    except sr.RequestError as e:
        print("Request to Google Speech Recognition service failed; {0}".format(e))
        return ""



#gemini data function to generate response 
def get_gemini_data(query):
    response = model.generate_content(query + 'in 30 words')
    response_text=response.text
    return response_text
    
    
        


# # # Example usage
# query = "What is fever."
# text = get_gemini_data(query)
# print(text)

patient_id = "example3"
base_url = "http://192.168.203.133:5000/"
# base_url_mobile is 192.168.203.222
# base_url_home is 192.168.29.183

# Main function
def main():
    ip = get_ip_address()
    print(f"ip is {ip}")
    # base_url = "http://"+ip+":5000/"
    speak("Welcome to SHRA, Say hello for assistant or emergency to connect to nurse")
    wakeup = listen()
    if "hello" in wakeup:
         speak("Hello! How can I assist you today?")
         while True:
             user_query = listen()
             if user_query == "exit":
                 speak("Hope I helped you today take care, get well soon!")
                 break
             elif "emergency" in user_query:
                 speak("Connecting to nearest available nurse")
                 response = requests.get(base_url+ "addalert/"+patient_id)
                 speak("Donot worry, I have sent alert to nurses")
                 main()
             else :
                 response = requests.post(base_url+ "generateresponse",data={"query": user_query})
                #  gemini_data = get_gemini_data(user_query)
                 response_text = "Here is what you should do now" + response.text
                 speak(response_text)
                 #print(response_text)
                 speak('If you want to end assistant say exit')
             
    elif "emergency" in wakeup:
        speak("Connecting to nearest available nurse")
        response = requests.get(base_url+ "addalert/"+patient_id)
        speak("Donot worry, I have sent alert to nurses")
        main()
    else:
        # main()
        speak("You are doing great, I dont think you need my assistance takecare bye!!")

   

if __name__ == "__main__":
    main()