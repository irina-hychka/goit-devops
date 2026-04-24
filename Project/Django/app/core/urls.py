from django.contrib import admin
from django.urls import path
from Project.Django.app.main.views import home_view, health_view

urlpatterns = [
    path("admin/", admin.site.urls),
    path("", home_view, name="home"),
    path("health/", health_view, name="health"),
]