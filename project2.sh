#! /bin/bash
#Script to mount a directory and change ownership

#Usage:
#    ./course_mount.sh -h To print this help message
#    ./course_mount.sh -m -c [course] For mounting a given course
#    ./course_mount.sh -u -c [course] For unmounting a given course
#    If course name is ommited all courses will be (un)mounted


#Exit Codes:
#       0: help or succesfully ran
#       1: Invalid Argruements
#       2: Already mounted or unmounted
#       -1: Course doesn't exist 
#	-2: Operation failed


function usage()
{

    echo ./course_mount.sh -h To print this help message
    echo ./course_mount.sh -m -c [course] For mounting a given course
    echo ./course_mount.sh -u -c [course] For unmounting a given course
    echo "If course name is ommited all courses will be (un)mounted"
}

DIR="/data/course"
while getopts "hmuc:" opt;
do
        case ${opt} in
                h)
                        usage
                        exit 0
                        ;;
                m)
                        MOUNT=0  # 0 for mount and 1 for unmount
                        ;;
                u)
                        MOUNT=1
                        ;;
                c)
                        DIR=${OPTARG}
                        ;;
                *)
                        echo Invalid Arguements
                        usage
                        exit 1
                        ;;
        esac
done


COURSE_PATH=/data/course/$DIR
TARGET_PATH="/home/trainee"


# Array to store leaf directories
declare -a COURSES=("Linux_course/Linux_course1"
                        "Linux_course/Linux_course2" "machinelearning/machinelearning1"
                        "machinelearning/machinelearning2","SQLFundamentals1"
                        "SQLFundamentals2" "SQLFundamentals3")



# check if course is mounted or not 
function check_mount()
{
        echo "Checking for mount"
        CHECK_FOR_MOUNT=1
        if [ $(mount | grep $DIR | wc -l) -gt 0 ]
        then
                CHECK_FOR_MOUNT=0
        fi
        
}

# Mount the course
function mount_course()
{

        for course in $COURSES
        do
                
                if [ $DIR==$course ]
                then
                        local check_dir=1 # flag to check if given directory is present or not
                        break
                fi
        done
        
        if [ $check_dir -eq 0 ]
        then
                echo "Course doesn't exists"
                exit -1
        elif [  $CHECK_FOR_MOUNT -eq 0 ]
        then
                echo The course is already mounted
                exit 2
        else
                echo Mounting $DIR
                if ! bindfs -p a-w -u trainee -g ftpaccess ${COURSE_PATH} ${TARGET_PATH}
		then 
			echo "Mount operation failed"
			exit -2
		fi
        fi


}

# Mount all courses
function mount_all()
{
        echo Mounting All Courses
        for course in $COURSES
        do
                if ! bindfs -p a-w -u trainee -g ftpaccess data/course/${course} ${TARGET_PATH}
		then
			echo "Mounting operation failed"
			exit -2
		fi
        done
        return 0
}

# Unmount Course
function unmount_course()
{
        
        for course in $COURSES
        do
                if [ $DIR==$course ]
                then
                        local check_dir=1  # flag to check if given directory is present or not
                        break
                fi
        done

        if [ $check_dir -eq 0 ]
        then
                echo "Course doesn't exists"
                exit -1
        elif [ $CHECK_FOR_MOUNT -eq 1 ]
        then 
                echo The course is NOT mounted
                exit 2
        else
                echo "Unmounting "$DIR
                if ! umount -f $COURSE_PATH
		then
			echo "Unmounting operation failed"
			exit -2
		fi
        fi

}

#Unmount all courses
function unmount_all()
{
        echo "Unmounting all courses"
        for course in $COURSES
        do
               umount -f data/course/$course
        done
        exit 0

}



# Change ownership of directories
sudo chown root:root /data/course 
sudo chown trainee:ftpaccess /home/trainee

# Change permissions
sudo chmod 455 home/trainee



if [ $MOUNT -eq 0 ]
then
        check_mount
	if [ -z $2 ]
	then
		mount_all
		exit 0
	else
        	mount_course
		exit 0
	fi
else
        check_mount
	if [ -z $3 ]
        then 
                unmount_all
		exit 0
        else
                unmount_course
		exit 0
        fi
fi


