########################################################
#------------------------------------------------------#
#
# Machine Perception and Cognitive Robotics Laboratory
#
#     Center for Complex Systems and Brain Sciences
#               Florida Atlantic University
#
#------------------------------------------------------#
########################################################
#------------------------------------------------------#
#LabManual


#timer

from rover import Rover20
import time


def main():
    rover = Rover20()  # create rover

    rover.turnLightsOn()  # turn on green lights
    time.sleep(1)

    rover.turnLightsOff()
    time.sleep(1)

    rover.close()  # close rover


main()
