# 💧 Projeto - ÁguaJá

## 📝 Descrição

**ÁguaJá** é um aplicativo mobile desenvolvido para auxiliar comunidades afetadas pela escassez de água. Ele oferece:

* 📅 **Agendamento** para coleta de água;
* 📍 **Localização** de pontos de distribuição mais próximos;
* 💡 **Dicas de economia** e uso consciente da água.

---

## 🛠️ Tecnologias Utilizadas

### 📱 Frontend

* **Flutter**: Framework principal para construção da interface mobile.
* **Material Design**: Estilo visual aplicado por padrão nos componentes.
* **Cupertino Icons**: Ícones com estilo iOS.

### 📍 Geolocalização e Mapas

* **Google Maps Flutter**: Exibição de mapas com pontos de distribuição.
* **flutter\_map**: Alternativa baseada em OpenStreetMap.
* **latlong2**: Manipulação de coordenadas geográficas.
* **geolocator**: Coleta da posição atual do usuário via GPS.

### 🗂️ Armazenamento Local

* **shared\_preferences**: Armazena pequenos dados localmente no dispositivo, como tokens ou preferências.

### 🌐 Internacionalização e Formatação

* **intl**: Formatação de datas, horas e números com base na localidade do usuário.

---

## 🔐 Informações de Login

Para testar a aplicação, utilize as seguintes credenciais padrão:

* **Email:** `teste`
* **Senha:** `teste`

---

## 🚀 Como Executar o Projeto Flutter no Android Studio

1. **Clone o repositório**

   ```bash
   git clone <URL-DO-REPOSITORIO>
   cd water_finder
   ```

2. **Abra no Android Studio**

   * Vá em `File > Open` e selecione a pasta do projeto.

3. **Instale as dependências**

   ```bash
   flutter pub get
   ```

4. **Execute no emulador ou dispositivo físico**

   * Use o botão de “Run” (`▶`) ou o atalho `Shift + F10`.

---

## ⚙️ Configuração do Ambiente Flutter

Antes de executar o projeto, é necessário configurar corretamente o ambiente Flutter em sua máquina.

👉 Acesse o guia oficial de instalação:
[https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)
