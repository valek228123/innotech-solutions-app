from django.urls import path
from .views import activate_email_view


app_name = 'authentication'
urlpatterns = [
    path('activate/<str:uid>/<str:token>/', activate_email_view, name='activate-email')
]