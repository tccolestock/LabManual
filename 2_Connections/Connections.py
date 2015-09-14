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

#Rover20 Class

#Battery Request

from rover import Rover20
import time


def main():


    rover = Rover20()  # create rover
    
    bat=rover.getBatteryPercentage()

	print('Battery level: %d%%' % bat)
    
    rover.close()  # close rover


main()



