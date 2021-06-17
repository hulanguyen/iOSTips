#FIRST
For autosize the cell base on the contents, we always need to add those line off code: 
Added those line below in viewDidLoad of file TableViewController:

    tableView.estimatedRowHeight = 44
    tableView.rowHeight = UITableView.automaticDimension

What dose those line of code do? 

-   Normally, a cell’s height is determined by the table view delegate’s tableView:heightForRowAtIndexPath: method. To enable self-sizing table view cells, you must set the table view’s rowHeight property to UITableViewAutomaticDimension. You must also assign a value to the estimatedRowHeight property. As soon as both of these properties are set, the system uses Auto Layout to calculate the row’s actual height.

    Link: ([I'm an inline-style link])(https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithSelf-SizingTableViewCells.html)
    

