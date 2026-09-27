package tz.rahanu.technology.model;

import java.time.LocalDate;

public class Project {

    private int id;
    private String title;
    private String slug;
    private String shortDescription;
    private String description;
    private String technologies;
    private String image;
    private String githubUrl;
    private String liveUrl;
    private LocalDate projectDate;
    private String status;
    private boolean featured;

    public Project() {
    }

    public Project(
            int id,
            String title,
            String slug,
            String shortDescription,
            String description,
            String technologies,
            String image,
            String githubUrl,
            String liveUrl,
            LocalDate projectDate,
            String status,
            boolean featured
    ) {
        this.id = id;
        this.title = title;
        this.slug = slug;
        this.shortDescription = shortDescription;
        this.description = description;
        this.technologies = technologies;
        this.image = image;
        this.githubUrl = githubUrl;
        this.liveUrl = liveUrl;
        this.projectDate = projectDate;
        this.status = status;
        this.featured = featured;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTechnologies() {
        return technologies;
    }

    public void setTechnologies(String technologies) {
        this.technologies = technologies;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getGithubUrl() {
        return githubUrl;
    }

    public void setGithubUrl(String githubUrl) {
        this.githubUrl = githubUrl;
    }

    public String getLiveUrl() {
        return liveUrl;
    }

    public void setLiveUrl(String liveUrl) {
        this.liveUrl = liveUrl;
    }

    public LocalDate getProjectDate() {
        return projectDate;
    }

    public void setProjectDate(LocalDate projectDate) {
        this.projectDate = projectDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isFeatured() {
        return featured;
    }

    public void setFeatured(boolean featured) {
        this.featured = featured;
    }
}
