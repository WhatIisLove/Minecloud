from flask import Flask
from mcstatus import JavaServer
import time

app = Flask(__name__)
server = JavaServer("minecraft", 25565)
cache = {}

@app.route('/')
def status():
    try:
        status = server.status()
        cache.update({
            'status': '🟢 EN LIGNE',
            'players': f"{status.players.online}/{status.players.max}",
            'version': getattr(status.version, 'name', 'Unknown'),
            'updated': time.strftime('%H:%M:%S')
        })
    except:
        cache.update({
            'status': '🔴 HORS LIGNE',
            'players': '0/20',
            'version': 'N/A',
            'updated': time.strftime('%H:%M:%S')
        })
    
    return f"""
    <!DOCTYPE html>
    <html>
    <head><title>MineCloud Status</title>
    <meta http-equiv="refresh" content="30">
    <style>
    body{{background:#0a0a0a;color:#0f0;font-family:monospace;padding:50px;text-align:center;}}
    h1{{font-size:4em;margin:20px 0;color:#00ff00;}}
    .status{{font-size:3em;margin:20px 0;}}
    .stats{{font-size:1.5em;margin:10px 0;}}
    a{{color:#4a90e2;text-decoration:none;}}
    </style>
    </head>
    <body>
    <h1>🎮 MineCloud Ops</h1>
    <div class="status">{cache['status']}</div>
    <div class="stats">👥 Joueurs: {cache['players']}</div>
    <div class="stats">⚙️ Version: {cache['version']}</div>
    <div class="stats">📅 Maj: {cache['updated']}</div>
    <hr>
    <p><a href="minecraft://127.0.0.1:25565">🚀 Connexion Minecraft</a></p>
    </body>
    </html>
    """

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
