package tz.rahanu.technology.model;

public class TeamMember {

    private int id;
    private String fullName;
    private String position;
    private String roleType;
    private String biography;
    private String skills;
    private String photo;
    private String linkedinUrl;
    private String githubUrl;
    private int displayOrder;
    private boolean active;

    public TeamMember() {
    }

    public TeamMember(
            int id,
            String fullName,
            String position,
            String roleType,
            String biography,
            String skills,
            String photo,
            String linkedinUrl,
            String githubUrl,
            int displayOrder,
            boolean active) {

        this.id = id;
        this.fullName = fullName;
        this.position = position;
        this.roleType = roleType;
        this.biography = biography;
        this.skills = skills;
        this.photo = photo;
        this.linkedinUrl = linkedinUrl;
        this.githubUrl = githubUrl;
        this.displayOrder = displayOrder;
        this.active = active;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getRoleType() {
        return roleType;
    }

    public void setRoleType(String roleType) {
        this.roleType = roleType;
    }

    public String getBiography() {
        return biography;
    }

    public void setBiography(String biography) {
        this.biography = biography;
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getLinkedinUrl() {
        return linkedinUrl;
    }

    public void setLinkedinUrl(String linkedinUrl) {
        this.linkedinUrl = linkedinUrl;
    }

    public String getGithubUrl() {
        return githubUrl;
    }

    public void setGithubUrl(String githubUrl) {
        this.githubUrl = githubUrl;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}
