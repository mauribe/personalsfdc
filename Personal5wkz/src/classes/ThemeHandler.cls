public class ThemeHandler {
    public ThemeHandler(ApexPages.StandardController controller) { }
    
    public static Set<String> getAvailableThemes() {
        // You must have at least one uploaded static resource
        // or this code will fail. List their names here.
        return(new Set<String> {'styles','styles2'});
    }
    public static List<SelectOption> getThemeOptions() {
        List<SelectOption> themeOptions = new List<SelectOption>();
        for(String themeName : getAvailableThemes()) {
            themeOptions.add(new SelectOption(themeName, themeName));
        }
        return themeOptions;
    }
    
    public String selectedTheme {
        get {
            if(null == selectedTheme) {
            // Ensure we always have a theme
            List<String> themeList = new List<String>();
            themeList.addAll(getAvailableThemes());
            selectedTheme = themeList[0];
        }
        return selectedTheme;
        }
        set {
            if(getAvailableThemes().contains(value)) {
                selectedTheme = value;
            }
        }
    }
}