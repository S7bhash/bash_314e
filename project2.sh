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



function usage()
{

    echo ./course_mount.sh -h To print this help message
    echo ./course_mount.sh -m -c [course] For mounting a given course
    echo ./course_mount.sh -u -c [course] For unmounting a given course
}


# check if course is mounted or not 
function check_mount()
{
        if [ $check_dir==1 ]
        then
                if $(mount | grep $DIR)
                then
                        return 0 
}

# Mount the course
function mount_course()
{
        check_dir=0 # flag to check if given directory is present or not

        for course in $COURSES
        do
                if [ $DIR==$course ]
                then
                        $check_dir=1
                        break
                fi
        done

        if [ $check_dir==0 ]
        then
                echo "Course doesn't exists"
                exit -1
        elif [ !check_mount ]
        then
                echo "Course doesn't exists"
                exit -1
        elif [ !check_mount ]
        then
                echo The course is already mounted
                exit 2
        else
                bindfs -p a-w -u trainee -g ftpaccess ${COURSE_PATH} ${TARGET_PATH}
                return 0
        fi


}

# Mount all courses
function mount_all()
{
        for course in $COURSES
        do
                bindfs -p a-w -u trainee -g ftpaccess ${course} ${TARGET_PATH}
        done
        return 0
}

# Unmount Course
function unmount_course()
{
        check_dir=0 # flag to check if given directory is present or not

        for course in $COURSES
        do
                if [ $DIR==$course ]
                then
                        $check_dir=1
                        break
                fi
        done

        if [ $check_dir==0 ]
        then
                echo "Course doesn't exists"
                exit -1
        elif [ !check_mount ]
        then 
                echo The course is already mounted
                exit 2
        else
                umount -f $COURSE_PATH
                return 0
        fi

}

#Unmount all courses
function unmount_all()
{
        for course in $COURSES
        do
               umount -f $course
        done
        return 0

}


# Array to store leaf directories

COURSES=("Linux_course/Linux_course1","Linux_course/Linux_course2","machinelearning/machinelearning1","machinelearning/machinelearning2","SQLFundamentals1","SQLFundamentals2","SQLFundamentals3")

MOUNT=0 # 0 for mount and 1 for unmount


while getopts "hmuc:" opt;
do
        case ${opt} in
                h)
                        usage
                        exit 0
                        ;;
                m)
                        $MOUNT=0
                        ;;
                u)
                        $MOUNT=1
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

COURSE_PATH=$DIR
TARGET_PATH="home/trainee"

# Change ownership of directories
chown root:root /data/course 
chown trainee:ftpaccess /home/trainee

# Change permissions
chmod 455 /home/trainee



if [ $MOUNT==0 ]
then
	if [ -z $3 ]
	then
		exit_code=mount_all
	else
        	exit_code=mount_course
	fi
else
	if [ -z $3 ]
        then 
                exit_code=unmount_all
        else
                exit_code=unmount_course
        fi
fi
exit $exit_code

