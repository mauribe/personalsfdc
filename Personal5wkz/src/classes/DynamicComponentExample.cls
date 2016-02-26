public with sharing class DynamicComponentExample {

    public DynamicComponentExample(ApexPages.StandardController controller) {}

    public Component.Apex.SectionHeader getHeaderWithDueDateCheck() {
    date dueDate = date.newInstance(2011, 7, 4);
    boolean overdue = date.today().daysBetween(dueDate) < 0;
    Component.Apex.SectionHeader sectionHeader = new Component.Apex.SectionHeader();
    if (overdue) {
    sectionHeader.title = 'This Form Was Due On ' + dueDate.format() + '!';
    return sectionHeader;
    } else {
        sectionHeader.title = 'Form Submission';
		return sectionHeader;
		}
	}
    
    public Component.Apex.PageBlock getPageBlockHeader() {
		    Component.Apex.PageBlock pageBlk = new Component.Apex.PageBlock();
			Component.Apex.PageBlockSection pageBlkSection = new Component.Apex.PageBlockSection(title='dummy header');
        	Component.Apex.PageBlockSection pageBlkSection2 = new Component.Apex.PageBlockSection(title='dummy header2');
            pageBlk.childComponents.add(pageBlkSection);
            pageBlk.childComponents.add(pageBlkSection2);
        return pageBlk;
        
    }
    

}