# IoT Monitoring Dashboard

Prototipe aplikasi Flutter untuk menampilkan data monitoring sensor IoT. Aplikasi
menggunakan data dummy dan belum terhubung ke NodeMCU maupun broker MQTT.

## Komponen UI

- **Live readings** menampilkan suhu `30.5 °C` dan kelembapan `75%` dari sensor
  simulasi DHT11.
- **MQTT connection** menunjukkan status koneksi contoh, broker, topic, serta
  waktu pembaruan data.
- **Monitoring history** menampilkan grafik suhu dan tabel empat pembacaan
  simulasi.
- **Refresh** memperbarui waktu pembaruan untuk demonstrasi interaksi UI.

## Menjalankan aplikasi

Pastikan Flutter SDK sudah terpasang, lalu jalankan dari folder project:

```shell
flutter pub get
flutter run
```

Jalankan pengujian UI dengan:

```shell
flutter test
```
