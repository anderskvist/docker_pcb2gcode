FROM ubuntu:18.04

LABEL maintainer="Anders Kvist <anderskvist@gmail.com>"

RUN apt-get update && apt-get -f -y install wget g++
RUN apt-get install -f -y libboost-all-dev
RUN apt-get install -f -y libglibmm-2.4-dev libgtkmm-2.4-dev gerbv

RUN wget https://github.com/pcb2gcode/pcb2gcode/releases/download/v1.3.2/pcb2gcode-1.3.2.tar.gz
RUN tar -xzvf pcb2gcode-1.3.2.tar.gz
RUN cd pcb2gcode-1.3.2 && ./configure && make -j && make install
COPY kicad_pcb2gcode_bungard.sh /

CMD ["/kicad_pcb2gcode_bungard.sh"]
WORKDIR /work

