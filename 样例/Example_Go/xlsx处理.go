/*package main

import (
	"fmt"
	"os"

	"./excelize"
)

func main() {
	xlsx := excelize.NewFile()
	// Create a new sheet.
	xlsx.NewSheet(2, "Sheet2")
	// Set value of a cell.
	xlsx.SetCellValue("Sheet2", "A2", "Hello world.")
	xlsx.SetCellValue("Sheet1", "B2", 100)
	// Set active sheet of the workbook.
	xlsx.SetActiveSheet(2)
	// Save xlsx file by the given path.
	err := xlsx.SaveAs("./Workbook.xlsx")
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
*/

package main

import (
	"./xlsx"
	"fmt"
)

func main() {
	var file *xlsx.File
	var sheet *xlsx.Sheet
	var row *xlsx.Row
	var cell *xlsx.Cell
	var err error

	file = xlsx.NewFile()
	sheet, err = file.AddSheet("Sheet1")
	sheet2, err := file.AddSheet("Sheet2")
	row2 := sheet2.AddRow()
	row2.SetHeight(50.2) //设置行高
	cell2 := row2.AddCell()
	cell2.SetString("hahahh")
	//cell2.Value = "I am a cell2!"
	new := xlsx.NewStyle()
	new.ApplyFill = true
	newfont := xlsx.NewFont(22, "NewRom") //字号和字体
	newfont.Color = "00008B"              //16进制颜色去掉前面的#
	newfont.Underline = true              //下划线
	newfont.Italic = true                 //斜体
	new.Font = *newfont
	cell2.SetStyle(new)
	if err != nil {
		fmt.Printf(err.Error())
	}
	row = sheet.AddRow()
	cell = row.AddCell()
	cell.Value = "I am a cell!"
	err = file.Save("MyXLSXFile.xlsx")
	if err != nil {
		fmt.Printf(err.Error())
	}
}

/*package main

import (
	"./xlsx"
	"fmt"
)

func main() {
	excelFileName := "./dome.xlsx"
	xlFile, err := xlsx.OpenFile(excelFileName)
	if err != nil {
		fmt.Println("aa")
	}
	for _, sheet := range xlFile.Sheets {
		for _, row := range sheet.Rows {
			for _, cell := range row.Cells {
				text := cell.String()
				if text != "" {
					fmt.Printf("%s\n", text)
				}
			}
			fmt.Println("================")
		}
	}
}
*/
