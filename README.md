# UAS-WEB
Cat Adoption Website for Final Semester Project (Operating Systems and Computer Networks).
# 🐱 Cat Adoption Website
Repositori ini memuat dokumentasi infrastruktur, konfigurasi reverse proxy, serta arsitektur sistem pemantauan (monitoring) untuk aplikasi **CatCare (Cat Adoption Website)** guna memenuhi nilai Tugas Akhir / Ujian Akhir Semester (UAS) mata kuliah **Sistem Operasi dan Jaringan Komputer**.

---

di buat oleh:
* **Cantik Rahmi Shofiyanti** - NIM: 251572010029

---

## 📌 Deskripsi Sistem & Target Arsitektur
Aplikasi CatCare di-deploy pada lingkungan server VPS produksi dengan spesifikasi arsitektur sebagai berikut:
* **Web Server & Pintu Gerbang:** Nginx (Konfigurasi Reverse Proxy)
* **Keamanan Akses:** SSL Tervalidasi via Certbot (Protokol HTTPS murni)
* **Isolasi Sistem:** Docker Containerization (Aplikasi berjalan pada port internal `9876`)
* **Pipeline Otomatis:** CI/CD menggunakan GitHub Actions Workflow
* **Sistem Pemantauan:** Uptime Kuma (Live monitoring status website)
* **Proteksi Data:** Skrip backup otomatis melalui penjadwalan *cron job*

---

## 🌐 Informasi Tautan Sistem (Live Links)

Seluruh sistem telah dideploy di dalam Virtual Private Server (VPS) dan dapat diakses melalui tautan publik aman berikut:
* **Aplikasi Web (CatCare):** [https://canmie.my.id](https://canmie.my.id) *(Proses migrasi dari [http://canmie.my.id:9876](http://canmie.my.id:9876) via Nginx Reverse Proxy)*
* **Dashboard Monitoring (Uptime Kuma):** [http://canmie.my.id:3001](http://canmie.my.id:3001)

---

## 🏗️ Diagram Arsitektur Sistem (Workflow)

Berikut adalah alur jalannya infrastruktur aplikasi dari lingkungan lokal hingga dapat diakses secara aman oleh pengguna:

```text
[ Developer PC ] ──( Git Push )──> [ GitHub Repository ]
                                           │
                                     ( SSH / Deploy )
                                           │
                                           ▼
                                   [ Ubuntu VPS Server ]
                                           │
                    ┌──────────────────────┴──────────────────────┐
                    │            Docker Container Engine          │
                    │                                             │
                    ▼                                             ▼
         [ Nginx Proxy Container ]                      [ Uptime Kuma ]
             (Port 80 / 443)                            (Port 3001:3001)
                    │                                             │
             (Reverse Proxy)                                 (Memantau)
                    │                                             │
                    ▼                                             │
         [ Web App Container ] <──────────────────────────────────┘
         (Port Internal: 9876)

📁 Struktur Repositori
Plaintext
.
├── .github/workflows/  # Berkas otomatisasi deployment (CI/CD Pipeline)
├── Dockerfile          # Spesifikasi pembuatan image container aplikasi
├── index.html          # Kode sumber utama halaman web CatCare
└── README.md           # Dokumentasi teknis proyek UAS
