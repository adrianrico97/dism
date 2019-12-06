# DISM (Device Inventory Simple Manager)

DISM é unha plataforma que nos permite xestionar dunha forma sinxela ao inventario de dispositivos electrónicos da nosa empresa e as súas incidencias

## DESPREGAR A APLICACIÓN

### 1. Instalar RVM para o control das versións de Ruby

  sudo apt-add-repository -y ppa:rael-gc/rvm
  sudo apt-get update
  sudo apt-get install rvm

Máis información sobre a instalación de RVM: https://github.com/rvm/ubuntu_rvm

### 2. Instalar Ruby versión 2.6.5

  rvm install "ruby-2.6.5"

### 3. Instalar as RubyGems
Debemos estar ubicados dentro do directorio do proxecto.

  bundle install

### 4. Instalar yarn
Seguir os pasos en: https://yarnpkg.com/lang/en/docs/install/#debian-stable

  yarn install

### 5. Instalar MySQL Server

  sudo apt install mysql-server

### 6. Crear e migrar a base de datos
Revisar credenciales de acceso a MySQL en config/database.yml

  rake db:create && rake db:migrate

### 7. Iniciar o servidor

  rails server

Podemos iniciarlo en modo producción:

  RAILS_ENV=production rails s

Podemos iniciar unha consola co seguinte comando:

  rails console

