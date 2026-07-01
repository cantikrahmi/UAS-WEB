# UAS-WEB
Cat Adoption Website for Final Semester Project (Operating Systems and Computer Networks).
# 🐱 Cat Adoption Website
Repository ini berisi dokumentasi deployment, konfigurasi reverse proxy, serta arsitektur sistem pemantauan (monitoring) untuk aplikasi **Cat Adoption** sebagai syarat pemenuhan nilai Tugas Akhir / Ujian Akhir Semester (UAS) mata kuliah Pengembangan Berbasis Web.

---

## 👥 Anggota Kelompok 
*   [CANTIK RAHMI SHOFIYANTI] - [251572010029]


---

## 🌐 Informasi Tautan Sistem (Live Links)
Seluruh sistem telah dideploy di dalam Virtual Private Server (VPS) dan dapat diakses melalui tautan publik berikut:
*   **Aplikasi Web (Cat Adoption):** [http://canmie.my.id:9876](http://canmie.my.id:9876)
*   **Dashboard Monitoring (Uptime Kuma):** [http://canmie.my.id:3001](http://canmie.my.id:3001)

---

## 🏗️ Diagram Arsitektur Sistem
Berikut adalah alur jalannya infrastruktur aplikasi dari lingkungan lokal hingga dapat diakses oleh pengguna:

```text
[ Developer PC ] ──( Git Push )──> [ GitHub Repository ]
                                           │
                                     ( SSH / Deploy )
                                           │
                                           ▼
                                   [ Ubuntu VPS Server ]
                                           │
                    ┌──────────────────────┴──────────────────────┐
                    │            Docker Compose Engine            │
                    │                                             │
                    ▼                                             ▼
         [ Nginx Proxy Container ]                      [ Uptime Kuma ]
             (Port 9876:80)                             (Port 3001:3001)
                    │                                             │
             (Reverse Proxy)                                 (Memantau)
                    │                                             │
                    ▼                                             │
         [ Web App Container ] <──────────────────────────────────┘
            (cat-adoption)

⚙️ Komponen Berkas Konfigurasi Utama
1. File Spesifikasi Multikontainer (docker-compose.yml)
YAML
version: '3.8'

services:
  web:
    image: uas-web-website:latest
    build: .
    container_name: cat-adoption
    restart: always

  nginx:
    image: nginx:alpine
    container_name: nginx-proxy
    ports:
      - "9876:80"
    volumes:
      - ./nginx.conf:/etc/nginx/conf.d/default.conf:ro
    depends_on:
      - web

  monitoring:
    image: louislam/uptime-kuma:1
    container_name: uptime-kuma
    ports:
      - "3001:3001"
    volumes:
      - uptime-kuma-data:/app/data
    restart: always

volumes:
  uptime-kuma-data:
2. File Aturan Proksifikasi (nginx.conf)
Nginx
server {
    listen 80;
    server_name canmie.my.id www.canmie.my.id;

    location / {
        proxy_pass http://web:80;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
📕 Prosedur Operasional Pemulihan Sistem (Runbook)
Panduan praktis ini wajib digunakan oleh tim untuk mengatasi kendala operasional saat sesi uji coba atau kendala teknis mendadak:

1. Cara Menyalakan Seluruh Sistem Dari Awal
Jika server mengalami force reboot or mati lampu, nyalakan kembali seluruh rangkaian kontainer (Aplikasi, Nginx, dan Uptime Kuma) secara background menggunakan perintah:

Bash
cd ~/UAS-WEB
docker compose up -d
2. Penanganan Error "502 Bad Gateway"
Error ini mengindikasikan kontainer proxy Nginx hidup, namun kehilangan kontak dengan kontainer internal aplikasi utama. Langkah penyelesaiannya:

Periksa apakah kontainer aplikasi mendadak crash atau mati:

Bash
docker ps -a
Analisis log error pada eksekusi mesin internal aplikasi:

Bash
docker logs cat-adoption
Lakukan restart penyegaran jaringan Docker:

Bash
docker compose restart
3. Penanganan Bentrok Kontainer (Container Name Conflict)
Jika proses pembaruan terhambat karena kontainer lama mengunci memori Docker, eksekusi pembersihan total secara paksa:

Bash
docker rm -f cat-adoption nginx-proxy
docker compose up -d
