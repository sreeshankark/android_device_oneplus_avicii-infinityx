package android.common;

public class OplusFrameworkFactory implements IOplusCommonFactory {
    public static OplusFrameworkFactory sInstance = null;

    public static OplusFrameworkFactory getInstance() {
        if (sInstance == null) {
            sInstance = new OplusFrameworkFactory();
        }
        return sInstance;
    }

    @Override
    public boolean isValid(int index) {
        boolean validOplus =
                index < OplusFeatureList.OplusIndex.EndOplusFrameworkFactory.ordinal() &&
                index > OplusFeatureList.OplusIndex.StartOplusFrameworkFactory.ordinal();
        boolean vaildOplusOs =
                index < OplusFeatureList.OplusIndex.EndOplusOsFrameworkFactory.ordinal() &&
                index > OplusFeatureList.OplusIndex.StartOplusOsFrameworkFactory.ordinal();
        return vaildOplusOs || validOplus;
    }
}
