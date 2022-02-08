
runAll:
	go run command/main.go && sudo docker start ecommerce

psqlEnter:
	sudo docker exec -it ecommerce bash

stop:
	sudo docker stop ecommerce

.PHONY:   runALL ,  , psqlEnter
