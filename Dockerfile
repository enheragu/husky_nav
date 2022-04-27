# Starts from oficial ros noetic core image
FROM ros:noetic-ros-core

# Basic setup of image, update and install utils
RUN apt-get update
RUN apt-get install --fix-missing
RUN apt-get install -y apt-utils
RUN apt-get -y install cmake make gcc g++

# Installation of husky pkgs and setup
RUN apt-get update
RUN apt update
RUN apt-get install ros-noetic-gazebo-ros-control -y --fix-missing
RUN apt-get install ros-noetic-husky-desktop -y --fix-missing
RUN apt-get install ros-noetic-husky-simulator -y --fix-missing
RUN echo "export HUSKY_GAZEBO_DESCRIPTION=$(rospack find husky_gazebo)/urdf/description.gazebo.xacro" > /root/.bashrc

# Install worlds
RUN apt-get install git -y
RUN mkdir -p cpr_worksp/src
RUN cd cpr_worksp/src && git clone https://github.com/clearpathrobotics/cpr_gazebo.git
# RUN cd cpr_worksp/src && git clone https://github.com/uuvsimulator/uuv_simulator
# RUN apt-get install protobuf-compiler protobuf-c-compiler -y
# RUN apt-get install python3-rosdep
# RUN rosdep init
# RUN rosdep update
# RUN cd cpr_worksp && /bin/bash -c '. /opt/ros/noetic/setup.bash && rosdep install --from-paths src --ignore-src --rosdistro=kinetic -y --skip-keys "gazebo gazebo_msgs gazebo_plugins gazebo_ros gazebo_ros_control gazebo_ros_pkgs"'
# RUN apt-get install ros-noetic-uv-gazebo-worlds -y
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash && cd cpr_worksp && catkin_make && . devel/setup.bash'
RUN echo ". /ros_entrypoint.sh && . /cpr_worksp/devel/setup.bash" > /root/.bashrc

RUN mkdir -p workspace/src
RUN echo ". /workspace/devel/setup.bash" > /root/.bashrc

# ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["/bin/bash"]