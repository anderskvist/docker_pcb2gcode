#!/bin/sh
# Generate front+back mill + cut gcode
#
# offset 0.125 (for isolation) can be tuned if pcb has room

mkdir output
cd output

pcb2gcode \
  --back ../*-B.Cu.gbr \
  --front ../*-F.Cu.gbr \
  --outline ../*-Edge.Cuts.gbr \
  --drill ../*.drl \
  --cut-feed=128 \
  --cut-infeed=0.7 \
  --cut-speed=2 \
  --cutter-diameter=1.0 \
  --milldrill \
  --milldrill-diameter=1.0 \
  --dpi=1000 \
  --drill-feed=256 \
  --drill-speed=0 \
  --metric \
  --metricoutput \
  --mill-feed=500 \
  --mill-speed=2 \
  --mill-vertfeed=254 \
  --offset=0.25 \
  --zchange=10 \
  --zcut=-1.4 \
  --zdrill=-1.6 \
  --zero-start \
  --zsafe=3 \
  --zwork=-0.1 \
  --extra-passes=1 \
  --onedrill \
  --drill-side back

# Strip tool changes from drill file
#
# notooldrill.ngc is the drill file without tool changes
grep -v "^T" milldrill.ngc > notooldrill.ngc

# Remove unsupported irrelevant g-code
grep -v "^G64" front.ngc | grep -v "^M6" > fix-front.ngc
grep -v "^G64" back.ngc | grep -v "^M6" > fix-back.ngc
# Mirror outline
grep -v "^G64" outline.ngc | sed -e 's/X/X-/g' > fix-outline.ngc
