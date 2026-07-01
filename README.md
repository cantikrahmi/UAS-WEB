# UAS-WEB
Cat Adoption Website for Final Semester Project (Operating Systems and Computer Networks).
# 🐱 Cat Adoption Website
Repository ini berisi dokumentasi deployment, konfigurasi reverse proxy, serta arsitektur sistem pemantauan (monitoring) untuk aplikasi **Cat Adoption** sebagai syarat pemenuhan nilai Tugas Akhir / Ujian Akhir Semester (UAS) mata kuliah Pengembangan Berbasis Web.

---

## 👥 Anggota Kelompok (Kelompok Canmie)
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
