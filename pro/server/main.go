package main

import (
	"fmt"
	"io/ioutil"
)

func main() {
	allFilePath := GetAllFilePath("E:/z_pn")
	allFilePath2 := GetAllFilePath("F:/z_pn")
	allFilePath = append(allFilePath, allFilePath2...)
	fmt.Println("begin print all file path")
	for i := 0; i < len(allFilePath); i++ {
		fmt.Println(allFilePath[i])
	}
}

func GetAllFilePath(folderPath string) []string {
	filePathList := make([]string, 0, 3)
	fileInfoList, err := ioutil.ReadDir(folderPath)
	if err != nil {
		fmt.Println("err")
	}
	for i := 0; i < len(fileInfoList); i++ {
		fileInfo := fileInfoList[i]
		//fmt.Println(fileInfo.Name())
		if fileInfo.IsDir() {
			dirPath := folderPath + "/" + fileInfo.Name()
			//fmt.Println(dirPath)
			subFilePathList := GetAllFilePath(dirPath)
			filePathList = append(filePathList, subFilePathList...)
		} else {
			filePathList = append(filePathList, folderPath+"/"+fileInfo.Name())
		}
	}
	return filePathList
}
