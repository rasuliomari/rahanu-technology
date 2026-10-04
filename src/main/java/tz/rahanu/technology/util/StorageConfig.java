package tz.rahanu.technology.util;

public final class StorageConfig {

private static final String DEFAULT_TEAM_UPLOAD_DIR =
        "/opt/rahanu-technology-data/team";

private StorageConfig() {
}

public static String getTeamUploadDirectory() {

    String directory =
            System.getenv("RAHANU_TEAM_UPLOAD_DIR");

    if (directory == null || directory.trim().isEmpty()) {
        return DEFAULT_TEAM_UPLOAD_DIR;
    }

    return directory.trim();
}
}
