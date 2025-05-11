from flask import Flask, request, jsonify
from dotenv import load_dotenv
import requests
import openai
import os
 
load_dotenv()
 
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
ELEVENLABS_API_KEY = os.getenv("ELEVENLABS_API_KEY")

app = Flask(__name__)
 
# API Keys
# OPENAI_API_KEY = "YOUR_OPENAI_API_KEY"
# ELEVENLABS_API_KEY = "YOUR_ELEVENLABS_API_KEY"
 
openai.api_key = OPENAI_API_KEY
 
voice_ids = {
    "Soft": "voice_id_1",
    "Motherly": "voice_id_2",
    "Gentle": "voice_id_3",
}
 
def generate_openai_response(user_input):
    try:
        response = openai.Completion.create(
            model="text-davinci-003",
            prompt=f"Act as a caring and soothing girlfriend who provides comfort. {user_input}",
            max_tokens=150,
            temperature=0.7
        )
        return response.choices[0].text.strip()
    except Exception as e:
        print(f"OpenAI Error: {e}")
        return "I'm here for you. Everything will be okay."
 
def generate_voice(text, voice):
    try:
        response = requests.post(
            "https://api.elevenlabs.io/v1/tts",
            headers={"xi-api-key": ELEVENLABS_API_KEY},
            json={"text": text, "voice_id": voice_ids[voice]}
        )
        response_data = response.json()
        return response_data.get("audio_url", "")
    except Exception as e:
        print(f"Eleven Labs Error: {e}")
        return ""
 
@app.route('/generate-text', methods=['POST'])
def generate_text():
    user_input = request.json['user_input']
    response_text = generate_openai_response(user_input)
    return jsonify({"response": response_text})
 
@app.route('/generate-voice', methods=['POST'])
def generate_voice_endpoint():
    text = request.json['text']
    voice = request.json['voice']
    audio_url = generate_voice(text, voice)
    return jsonify({"audio_url": audio_url})
 
if __name__ == "__main__":
    app.run(debug=True)