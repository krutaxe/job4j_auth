# Уровень "Middle"

## *Spring проект "job4j_auth"*

  •RestFull API архитектура - это архитектура клиент-серверного приложения базирующаяся на 6 принципах.
      1. Универсальный интерфейс взаимодействия. (Uniform Interface)
      2. Запросы без состояния. (Stateless)
      3. Поддержка кеширования. (Cacheable)
      4. Клиент-серверная ориентация.
      5. Поддержка слоев (Layered System)
      6. Возможность выполнять код на стороне клиента (Code on Demand)
      
	        •HTTP протокол, HTTP methods.
      1. GET - используется для получение данных. Не должен изменять данные на сервере.
      2. HEAD - аналогично GET. но не содержит тела ответа.
      3. POST - используется для изменения данных на сервера.
      4. PUT - аналог POST.
      5. DELETE - удаляет данные с сервера. Не содержит тела ответа.
      6. CONNECT - проверяет соединение с сервером.
      7. OPTIONS - используется для получения информации о сервере.
      8. TRACE - используется для тестирования соединения с дополнительной информацией.
  
	        •HTTP Status.
      1XX - информационные. например. 101 - переключение протокола с http на https
      2XX - запрос выполнен на сервере успешно.
      3XX - запрос был перенаправлен на другой URI.
      4XX - ошибки, связанные с клиентом. Например, 403 - у клиента нет доступа к серверу.
      5XX - ошибки, связанные с сервером. 500 - сервер упал.
      
      
            •Запуск приложения.

      Запуск с помощью командной строки:
       1.Перейти в папку с проектом.
       2.Выполнить команду: mvn liquibase:update
       3.Выполнить команду: mvn clean install
       4.Выполнить команду: mvn spring-boot:run
       5.Перейти по ссылке: http://localhost:8080/person/
       
      Запуск в контейнере с использованием docker-compose(Multi-stage build).
       1. Создайте образ командой `docker-compose build`
       2. Запустите образы БД и приложения командой `docker-compose up -d`  
       3. Остановить контейнеры БД иприложения командой `docker-compose down`.

      Запуск запуск приложения с использованием Kubernetes (K8s).
       1. Запустите кластер minikube start
       2. Создайте файл postgresdb-secret.yml и примените его kubectl apply -f postgresdb-secret.yml
       3. Создайте файл postgresdb-configmap.yml и примените его kubectl apply -f postgresdb-configmap.yml
       4. Создайте файл postgresdb-deployment.yml и примените его kubectl apply -f postgresdb-deployment.yml
       5. Создайте файл spring-deployment.yml и запускаем создание развертывания kubectl apply -f spring-deployment.yml
       6. Проверяем работу сервиса kubectl get service
       7. Получаем URL для подключению к сервису из вне minikube service spring-boot-service
       

