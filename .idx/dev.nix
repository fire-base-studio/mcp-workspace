# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "unstable"; # or "stable-24.05"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.nodejs_24
  ];
  # Sets environment variables in the workspace
  env = {};
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # Линтер для JavaScript/TypeScript. Поможет нам писать чистый код.
      "dbaeumer.vscode-eslint"

      # Автоматическое форматирование кода. Для единого стиля.
      "esbenp.prettier-vscode"

      # Подсветка синтаксиса, автодополнение и команды для Dockerfile.
      "ms-azuretools.vscode-docker"

      # Подсветка синтаксиса для .env файлов, которые мы будем использовать для секретов.
      "mikestead.dotenv"
    ];

    # 4. КОНФИГУРАЦИЯ РАБОЧЕЙ ОБЛАСТИ: Автоматизация задач.
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {};
      # To run something each time the workspace is (re)started, use the `onStart` hook
      onStart = {
        # Устанавливаем зависимости нашего сервера.
        install = "cd phase-1 && npm install";
        # Сразу запускаем сервер в фоновом режиме.
        start = "cd phase-1 && npm start";
      };

    };
    # Настройка окна предпросмотра (Preview).
    previews = {
      enable = true;
      previews = {
        # Имя превью: "server"
        server = {
          # Команда для запуска сервера
          command = ["npm" "run" "start"];
          # Рабочая директория для команды
          cwd = "phase-1";
          # Менеджер "web" говорит IDX, что это веб-сервер
          manager = "web";
        };
      };
    };
  };
  services = {
    docker = {
      enable = true;
    };
  };
}