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

from rover import Rover
import time

#Rover is a file created to connect this program with the physical device itself.
# Make sure you see it in the top left of the screen with its other programs like blowfish.
def main():
    rover = Rover()  # create rover
    bat=rover.get_battery_percentage() #Now that the rover is on and using the specific Rover class, you
    #can now type in the command for battery percentage (which can be found in the Rover class).
    print('Battery level: %d%%' % bat) #Now tell it to give you the percentage.
    rover.close()  # close rover
#Now run the program and Voila! You now know how much energy your rover has!


main()