from django.shortcuts import render
from rest_framework.decorators import api_view

@api_view(['GET'])
def activate_email_view(request, uid, token):

    context = {
        'uid': uid,
        'token': token,
    }
    return render(request, 'authentication/activate.html', context)