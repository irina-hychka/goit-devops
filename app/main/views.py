from django.http import HttpResponse, JsonResponse

def home_view(request):
    return HttpResponse(
        "<h1>Django + PostgreSQL + Nginx</h1>"
        "<p>The containerized project is running successfully.</p>"
        "<p>Open <a href='/health/'>/health/</a> to check the API response.</p>"
    )

def health_view(request):
    return JsonResponse(
        {
            "status": "ok",
            "message": "The Django application is running behind Nginx.",
        }
    )
