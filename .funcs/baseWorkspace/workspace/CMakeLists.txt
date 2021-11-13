cmake_minimum_required(VERSION 3.18)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


get_filename_component(ProjectId ${CMAKE_CURRENT_SOURCE_DIR} NAME)
string(REPLACE " " "_" ProjectId ${ProjectId})
project(${ProjectId} C CXX)

Include(FetchContent)
FetchContent_Declare(
	Catch2
	GIT_REPOSITORY https://github.com/catchorg/Catch2.git
	GIT_TAG        v2.13.1)
FetchContent_MakeAvailable(Catch2)


file(GLOB_RECURSE h
	${PROJECT_SOURCE_DIR}/src/*.h
	${PROJECT_SOURCE_DIR}/test/*.h
)


file(GLOB_RECURSE cpp
	TestRunner.cpp
	${PROJECT_SOURCE_DIR}/src/*.cpp
	${PROJECT_SOURCE_DIR}/test/*.cpp
)

list(FILTER cpp EXCLUDE REGEX "${PROJECT_SOURCE_DIR}/build/*")

add_executable(${PROJECT_NAME} ${h} ${cpp})

target_link_libraries(${PROJECT_NAME} PRIVATE Catch2::Catch2)
target_include_directories(${PROJECT_NAME} PRIVATE "${PROJECT_SOURCE_DIR}/src/")

if(MSVC)
  set_property(DIRECTORY ${CMAKE_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})
endif()
