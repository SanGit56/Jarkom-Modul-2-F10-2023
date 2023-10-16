# Jarkom-Modul-2-F10-2023
Laporan resmi praktikum modul 2 gns, dns, &amp; web server mata kuliah jaringan komputer
Kelompok: F10 <br />
Nama anggota 1: Radhiyan M Hisan <br />
NRP anggota 1: 5025211166 <br />
Nama anggota 2: Thoriq Afif Habibi <br />
NRP anggota 2: 5025211154 <br />

## 1. Buat topologi jaringan
Topologi 7 adalah topologi yang digunakan kelompok kami, kelompok F10<br />
![Topologi 7](tangkaplayar/1.png)

## 2. Buat website utama dengan akses ke arjuna.f10.com dengan alias www.arjuna.f10.com
_Script_ yang digunakan adalah makeArjuna.sh yang dijalankan di node YudhistiraDNSMaster dan melakukan perintah:
1. Menambahkan domain **arjuna.f10.com** di **/etc/bind/named.conf.local**
2. Pada file domain **arjuna.f10.com** mengarahkan alamat IP-nya ke _node_ **ArjunaLoadBalancer**
3. Menambahkan _record_ CNAME untuk membuat alias website<br />

Perintah yang digunakan dalam pengetesan adalah:<br />
1. ping arjuna.f10.com -c 2
2. host -t CNAME www.arjuna.f10.com
3. ping www.arjuna.f10.com -c 2<br />

![tes arjuna.f10.com](tangkaplayar/2.png)

## 3. Buat website utama dengan akses ke abimanyu.f10.com dengan alias www.abimanyu.f10.com
_Script_ yang digunakan adalah makeAbimanyu.sh yang dijalankan di node YudhistiraDNSMaster dan melakukan perintah:
1. Menambahkan domain **abimanyu.f10.com** di **/etc/bind/named.conf.local**
2. Pada file domain **abimanyu.f10.com** mengarahkan alamat IP-nya ke _node_ **AbimanyuWebServer**
3. Menambahkan _record_ CNAME untuk membuat alias website<br />

Perintah yang digunakan dalam pengetesan adalah:<br />
1. ping abimanyu.f10.com -c 2
2. host -t CNAME www.abimanyu.f10.com
3. ping www.abimanyu.f10.com -c 2<br />

![tes abimanyu.f10.com](tangkaplayar/3.png)

## 4. Buat subdomain parikesit.abimanyu.f10.com yang mengarah ke AbimanyuWebServer
_Script_ yang digunakan adalah makeParikesit.sh yang dijalankan di node YudhistiraDNSMaster dan melakukan perintah:
1. Pada file domain **abimanyu.f10.com** menambahkan _record_ A untuk membuat subdomain suatu _website_<br />

Perintah yang digunakan dalam pengetesan adalah:<br />
1. host -t A parikesit.abimanyu.f10.com
2. ping parikesit.abimanyu.f10.com -c 2<br />

![tes parikesit.abimanyu.f10.com](tangkaplayar/4.png)

## 5. Buat reverse domain untuk domain abimanyu.f10.com
_Script_ yang digunakan adalah makeReverse.sh yang dijalankan di node YudhistiraDNSMaster dan melakukan perintah:
1. Menambahkan domain reverse **3.226.192.in-addr.arpa** di **/etc/bind/named.conf.local**
2. Pada file domain **3.226.192.in-addr.arpa** membuat _nameserver_ dan mengarahkan ke **abimanyu.f10.com**<br />

Perintah yang digunakan dalam pengetesan adalah:<br />
1. host -t PTR 192.226.3.3<br />

![tes Reverse DNS abimanyu.f10.com](tangkaplayar/5.png)

## 6. Buat Werkudara sebagai DNS Slave dari DNS Master Yudhistira
_Script_ yang digunakan adalah makeMaster.sh yang dijalankan di node YudhistiraDNSMaster dan melakukan perintah:
1. Di **/etc/bind/named.conf.local** menambahkan baris `also-notify` dan `allow-transfer` yang mengarah ke IP WerkudaraDNSSlave pada tiap domain yang terdaftar termasuk reverse DNS<br />
_Script_ yang digunakan adalah makeSlave.sh yang dijalankan di node WerkudaraDNSSlave dan melakukan perintah:
2. Di **/etc/bind/named.conf.local** menambahkan baris `masters` yang mengarah ke IP YudhistiraDNSMaster pada tiap domain yang terdaftar termasuk reverse DNS<br />

Langkah yang digunakan dalam pengetesan adalah:<br />
1. Matikan _node_ YudhistiraDNSMaster
2. Jalankan perintah apapun (contoh: ping arjuna.f10.com -c 2)<br />

![tes DNS Slave](tangkaplayar/6.png)

## 7. Buat subdomain baratayuda.abimanyu.f10.com dengan alias www.baratayuda.abimanyu.f10.com yang didelegasikan dari Yudhistira ke Werkudara dengan IP menuju ke Abimanyu dalam folder Baratayuda
_Script_ yang digunakan adalah makeDelegator.sh yang dijalankan di node YudhistiraDNSMaster dan melakukan perintah:
1. Di **abimanyu.f10.com** menambahkan _record_ A dengan _root_ **ns1** dan _record_ NS dengan _root_ **baratayuda**
2. Menutup kode `dnssec-validation auto;` dan menambahkan kode `allow-query{any;};` di file **/etc/bind/named.conf.options**<br />

_Script_ yang digunakan adalah makeDelegate.sh yang dijalankan di node WerkudaraDNSSlave dan melakukan perintah:
1. Menutup kode `dnssec-validation auto;` dan menambahkan kode `allow-query{any;};` di file **/etc/bind/named.conf.options**
2. Menambahkan domain **baratayuda.abimanyu.f10.com** di **/etc/bind/named.conf.local**
3. Menambahkan _record_ CNAME untuk membuat alias website<br />

Perintah yang digunakan dalam pengetesan adalah:<br />
1. ping baratayuda.abimanyu.f10.com -c 2
2. host -t CNAME www.baratayuda.abimanyu.f10.com
3. ping www.baratayuda.abimanyu.f10.com -c 2<br />

![tes baratayuda.abimanyu.f10.com](tangkaplayar/7.png)

## 8. Buat subdomain rjp.baratayuda.abimanyu.yyy.com melalui Werkudara dengan alias www.rjp.baratayuda.abimanyu.yyy.com yang mengarah ke Abimanyu
_Script_ yang digunakan adalah makeRjp.sh yang dijalankan di node WerkudaraDNSSlave dan melakukan perintah:
1. Pada file domain **baratayuda.abimanyu.f10.com** menambahkan _record_ A untuk membuat subdomain suatu _website_
2. Menambahkan _record_ CNAME untuk membuat alias website<br />

Perintah yang digunakan dalam pengetesan adalah:<br />
1. ping rjp.baratayuda.abimanyu.f10.com -c 2
2. ping www.rjp.baratayuda.abimanyu.f10.com -c 2<br />

![tes rjp.baratayuda.abimanyu.f10.com](tangkaplayar/8.png)

## 9. Setel Load Balancer Nginx Arjuna dengan tiga worker yaitu Prabakusuma, Abimanyu, dan Wisanggeni (yang juga menggunakan nginx sebagai webserver)
Pada tiap worker menggunakan _script_ makeWorker.sh yang melakukan perintah:
1. Instalasi nginx dan PHP
2. Unduh dan proses file _resource_ untuk _worker_
3. Sesuaikan dari _port_ mana worker tersebut berjalan pada baris `listen 800x;`<br />

Perintah yang digunakan dalam pengetesan adalah:<br />
1. nginx -t<br />

![tes nginx Load Balancer](tangkaplayar/9a.png)
![tes nginx Worker](tangkaplayar/9b.png)

## 10. Gunakan algoritma Round Robin untuk Load Balancer pada Arjuna. Kmudian pastikan worker yang digunakan untuk menangani permintaan akan berganti ganti secara acak
_Script_ yang digunakan adalah makeLB.sh yang dijalankan di node ArjunaLoadBalancer dan melakukan perintah:
1. Pada file **/etc/nginx/sites-available/lb-arjuna** menyetel bahwa algoritma penyeimbang beban yang digunakan adalah Round Robin, sesuai worker yang ada
```
upstream myweb  {
    server 192.226.3.2:8001; #IP PrabukusumaWebServer
    server 192.226.3.3:8002; #IP AbimanyuWebServer
    server 192.226.3.4:8003; #IP WisanggeniWebServer
}
```
Perintah yang digunakan dalam pengetesan adalah:<br />
1. lynx arjuna.f10.com
![tes worker load balancer](tangkaplayar/10.png)

## 11. Konfigurasi web www.abimanyu.f10.com dengan Apache Web Server dan DocumentRoot di /var/www/abimanyu.f10
Konfigurasi www.abimanyu.f10.com menggunakan skrip abimanyuConf.sh dengan langkah-langkah berikut:
1. Menyalin konfigurasi default apache (file 000-default.conf) pada folder "/etc/apache2/sites-available" dengan nama file "abimanyu.f10.conf" ke folder yang sama dengan command `cp`
2. Mendownload resource dari google drive dan unzip ke folder "/var/www/abimanyu.f10" sebagai document root dengan command `wget` dan `unzip`
3. Membuat konfigurasi virtualHost dengan "DocumentRoot /var/www/abimanyu.f10", "ServerName abimanyu.f10.com", dan "ServerAlias www.abimanyu.f10.com" dengan menaruh ke variabel `conf` dan dituliskan ke file "abimanyu.f10.conf"
4. Mengaktifkan konfigurasi dengan perintah `a2ensite abimanyu.f10`
5. Merestart web server apache2  dengan perintah `service apache2 restart`

Untuk melakukan testing, saya mengakses web dengan `lynx abimanyu.f10.com/abimanyu.webp` `lynx abimanyu.f10.com/home.html` pada klien. Hasil yang diberikan sebagai berikut:<br>

- home.html<br>
![SS akses abimanyu.f10.com/home.html](tangkaplayar/11a.png)<br />
- abimanyu.webp<br>
![SS akses abimanyu.f10.com/abimanyu.webp](tangkaplayar/11b.png)<br />

## 13. Konfigurasi web www.parikesit.abimanyu.f10.com degan DocumentRoot di /var/www/parikesit.abimanyu.f10
Konfigurasi www.parikesit.abimanyu.f10.com menggunakan skrip parikesitConf.sh dengan langkah-langkah berikut:
1. Menyalin konfigurasi default apache (file 000-default.conf) pada folder "/etc/apache2/sites-available" dengan nama file "parikesit.abimanyu.f10.conf" ke folder yang sama dengan command `cp`
2. Mendownload resource dari google drive dan unzip ke folder "/var/www/parikesit.abimanyu.f10" sebagai document root dengan command `wget` dan `unzip`
3. Membuat folder `/secret` di dalam folder "/var/www/parikesit.abimanyu.f10" dengan command `mkdir`
4. Membuat konfigurasi virtualHost dengan "DocumentRoot /var/www/parikesit.abimanyu.f10", "ServerName parikesit.abimanyu.f10.com", dan "ServerAlias www.parikesit.abimanyu.f10.com" dengan menaruh ke variabel `conf` dan dituliskan ke file "abimanyu.f10.conf"
5. Mengaktifkan konfigurasi dengan perintah `a2ensite parikesit.abimanyu.f10`
6. Merestart web server apache2  dengan perintah `service apache2 restart`

Untuk melakukan testing, saya mengakses web dengan `lynx parikesit.abimanyu.f10.com` di klien dengan hasil:

![SS akses parikesit.abimanyu.f10.com](tangkaplayar/13.png)<br />

## 14. Pada www.parikesit.abimanyu.f10.com, folder /public hanya dapat melakukan directory listing dan folder /secret tidak dapat diakses (403 forbidden)
Pengaktifan directory listing pada folder `public` dan pembatasan akses pada folder `secret` dapat dilakukan dengan menambahkan konfigurasi berikut pada konfigurasi virtualHost file `parikesit.abimanyu.f10.conf`:
```R
<Directory /var/www/parikesit.abimanyu.f10/public>
		Options +Indexes
</Directory>

<Directory /var/www/parikesit.abimanyu.f10/secret>
	Options -Indexes
</Directory>
```
Agar konfigurasi yang baru aktif, saya juga melakukan restart service apache2<br>
Untuk melakukan testing, saya mengakses folder public dan secret melalui klien dengan hasil:<br>

- lynx parikesit.abimanyu.f10.com/public<br>
![SS akses parikesit.abimanyu.f10.com/public](tangkaplayar/14a.png)<br />
- lynx parikesit.abimanyu.f10.com/secret<br>
![SS akses parikesit.abimanyu.f10.com/secret](tangkaplayar/14b.png)<br />

## 15. Kustomisasi halaman error pada parikesit.abimanyu.f10.com
Pada soal ini, halaman error yang muncul akan diubah dengan file html yang ada pada folder `/error`. Pengubahan halaman error ini dapat dilakukan dengan menambahkan hal berikut pada konfigurasi virtualHost file `parikesit.abimanyu.f10.conf`:
```R
ErrorDocument 403 /error/403.html
ErrorDocument 404 /error/404.html
```
Agar konfigurasi yang baru aktif, saya juga melakukan restart service apache2<br>
Untuk melakukan testing, saya mencoba mengakses "parikesit.abimanyu.f10.com/secret" dan "parikesit.abimanyu.f10.com/yyy" sebagai error 403 dan 404. Hasil yang didapatkan adalah sebagai berikut:<br>

- lynx parikesit.abimanyu.f10.com/secret (error 403)<br>
![SS akses parikesit.abimanyu.f10.com/secret](tangkaplayar/15a.png)<br />
- lynx parikesit.abimanyu.f10.com/yyy (error 404)<br>
![SS akses parikesit.abimanyu.f10.com/yyy](tangkaplayar/15b.png)<br />

## 16. File asset www.parikesit.abimanyu.yyy.com/public/js menjadi www.parikesit.abimanyu.yyy.com/js
Directory alias "www.parikesit.abimanyu.yyy.com/js" dapat dibuat dengan menambahkan hal berikut pada konfigurasi virtualHost file `parikesit.abimanyu.f10.conf`:
```R
Alias \"/js\" \"/var/www/parikesit.abimanyu.f10/public/js\"
```
Agar konfigurasi yang baru aktif, saya juga melakukan restart service apache2<br>
Untuk melakukan testing, saya mencoba mengakses "parikesit.abimanyu.f10.com/public/js" dan "parikesit.abimanyu.f10.com/js". Berdasarkan gambar di bawah, dapat dilihat bahwa hasil sama yang menandakan bahwa directory alias telah aktif:<br>

- lynx parikesit.abimanyu.f10.com/public/js<br>
![SS akses parikesit.abimanyu.f10.com/public/js](tangkaplayar/16a.png)<br />
- lynx parikesit.abimanyu.f10.com/js<br>
![SS akses parikesit.abimanyu.f10.com/js](tangkaplayar/16b.png)<br />

## 17. Konfigurasi rjp.baratayuda.abimanyu.f10.com hanya dapat diakses melaui port 14000 dan 14400
Konfigurasi rjp.baratayuda.abimanyu.f10.com menggunakan skrip rjpConf.sh dengan langkah-langkah berikut:
1. Menyalin konfigurasi default apache (file 000-default.conf) pada folder "/etc/apache2/sites-available" dengan nama file "rjp.baratayuda.abimanyu.f10.conf" ke folder yang sama dengan command `cp`
2. Mendownload resource dari google drive dan unzip ke folder "/var/www/abimanyu.f10" sebagai document root dengan command `wget` dan `unzip`
3. Membuat konfigurasi virtualHost dengan "DocumentRoot /var/www/abimanyu.f10", "ServerName abimanyu.f10.com", dan "ServerAlias www.abimanyu.f10.com" dengan menaruh ke variabel `conf` dan dituliskan ke file "abimanyu.f10.conf"
4. Pada konfigurasi virtualHost, definisikan port agar hanya dapat diakses pada 14000 dan 14400 dengan `<VirtualHost *:14000 *:14400>`
5. Ubah konfigurasi port pada "/etc/apache2/ports.conf" dengan menambahkan `Listen 14000` dan `Listen 14400`
6. Mengaktifkan konfigurasi dengan perintah `a2ensite rjp.baratayuda.abimanyu.f10`
7. Merestart web server apache2  dengan perintah `service apache2 restart`

Untuk melakukan testing, saya mencoba akses "rjp.baratayuda.abimanyu.f10.com", "rjp.baratayuda.abimanyu.f10.com:14000", dan "rjp.baratayuda.abimanyu.f10.com:14400" dengan hasil:

- lynx rjp.baratayuda.abimanyu.f10.com<br>
![SS akses rjp.baratayuda.abimanyu.f10.com](tangkaplayar/17a.png)<br />
- lynx rjp.baratayuda.abimanyu.f10.com:14000<br>
![SS akses rjp.baratayuda.abimanyu.f10.com:14000](tangkaplayar/17b.png)<br />
- lynx rjp.baratayuda.abimanyu.f10.com:14400<br>
![SS akses rjp.baratayuda.abimanyu.f10.com:14400](tangkaplayar/17c.png)<br />

## 18. Menambahkan autentikasi pada rjp.baratayuda.abimanyu.f10.com dan meletakkan documentRoot di /var/www/rjp.baratayuda.abimanyu.f10
Penambahan autentikasi pada rjp.baratayuda.abimanyu.f10.com menggunakan skrip makeAuth.sh dengan langkah-langkah berikut:
1. Membuat username `wayang` dan `password` yang diletakkan pada file "/etc/apache2/.htpasswd" dengan command "echo "baratayudaf10" | htpasswd -ci /etc/apache2/.htpasswd Wayang"
2. Mengaktifkan mode autentikasi dengan command "a2enmod auth_basic" dan "a2enmod authn_file"
3. Menambahkan skrip berikut pada konfigurasi virtualHost file "rjp.baratayuda.abimanyu.f10.conf"
```R
<Directory /var/www/rjp.baratayuda.abimanyu.f10>
	AuthType Basic
	AuthName "Private Area"
	AuthUserFile /etc/apache2/.htpasswd
	Require valid-user
</Directory>
```
4. Merestart web server apache2  dengan perintah `service apache2 restart`

Untuk melakukan testing, saya mencoba akses kembali "rjp.baratayuda.abimanyu.f10.com" yang kemudian meminta username dan password seperti berikut:

- Meminta username<br>
![username](tangkaplayar/18a.png)<br />
- Meminta password<br>
![password](tangkaplayar/18b.png)<br />

## 19. Akses IP abimanyuWebServer dialihkan ke www.abimanyu.f10.com
Akses IP akan mengikuti konfigurasi default sehingga pengalihan ke abimanyu.f10.com dapat dilakukan dengan mengubah konfigurasi default menjadi:
```R
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/abimanyu.f10
	ServerName abimanyu.f10.com

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined

</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```

Untuk melakukan testing, saya menjalankan "lynx 192.226.3.3/home.html" pada klien dengan hasil:<br>
![IP](tangkaplayar/19.png)<br />

## 20. Mengalihkan request gambar dengan substring "abimanyu" ke abimanyu.png
Pengalihan request gambar ke abimanyu.png menggunakan skrip redirectImage.sh dengan langkah-langkah berikut:
1. Menambahkan hal berikut ke konfigurasi virtualHost file "parikesit.abimanyu.f10.conf"
```R
<Directory /var/www/parikesit.abimanyu.f10>
	Options +FollowSymLinks -Multiviews
	AllowOverride All
</Directory>
```
2. Membuat file `.htaccess` pada folder "/var/www/parikesit.abimanyu.f10"
3. Mengaktifkan rewrite engine dengan menambahkan "RewriteEngine On" ke file `.htaccess`
4. Menambahkan rewrite condition untuk memilih request yang akan di-rewrite. Kondisi yang di-rewrite adalah request yang mengandung "abimanyu", request berekstensi "jpeg, jpg, png, atau gif", dan bukan merupakan request ke abimanyu.png. Kondisi ini dapat diterapkan dengan menambah kode berikut ke file `.htaccess`
```R
RewriteCond %{REQUEST_URI} abimanyu [NC]
RewriteCond %{REQUEST_URI} \.(jpg|jpeg|png|gif)$ [NC]
RewriteCond %{REQUEST_URI} !/public/images/abimanyu.png
```
5. Mengarahkan request yang memenuhi semua kondisi di atas dengan menambahkan "RewriteRule ^(.*)$ /public/images/abimanyu.png [R=301,L]" ke `.htaccess`

Untuk melakukan testing, saya mencoba akses "abimanyu-student.jpg" dan "notabimanyujustmuseum.177013":

- lynx parikesit.abimanyu.f10.com/public/images/abimanyu-student.jpg<br>
![abimanyu](tangkaplayar/20a.png)<br />
- lynx parikesit.abimanyu.f10.com/public/images/notabimanyujustmuseum.177013<br>
![notAbimanyu](tangkaplayar/20b.png)<br />

## Kendala
- file index.php pada abimanyu.f10.com tidak dapat dibaca sehingga ketika diakses, tidak diarahkan ke home.html seperti pada logika di skripnya. Namun, akses ke file `home.html` secara langsung dapat memunculkan isi dari file html.

## Revisi
- Nomor 20: Penambahan perintah "a2enmod rewrite" pada skrip redirectImage.sh untuk mengaktifkan modul rewrite. Pada saat praktikum, saya mengaktifkan di terminal tanpa memasukkan ke skrip.