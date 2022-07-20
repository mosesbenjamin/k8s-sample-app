.PHONY: run_website stop_website

run_website:
	docker build -t sampleapp.com . && \
	  docker run --rm --name sampleapp.com -p 8000:80 -d sampleapp.com

stop_website:
	docker stop sampleapp.com