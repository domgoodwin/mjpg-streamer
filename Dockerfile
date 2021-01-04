FROM debian:buster

RUN mkdir /app
WORKDIR /app

COPY ./mjpg-streamer-experimental ./

RUN apt update
RUN apt install cmake python-pil libjpeg-dev -y

RUN make CMAKE_BUILD_TYPE=Debug

RUN make install

ENV LD_LIBRARY_PATH=.

EXPOSE 8080

ENTRYPOINT ["./mjpg_streamer" "-o output_http.so" "-w ./www" "-i \"input_raspicam.so -vf -hf\""]
