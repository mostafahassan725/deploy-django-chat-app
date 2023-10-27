from channels.routing import URLRouter
from homeApp.consumers import ChatConsumer

websocket_urlpatterns = [
    URLRouter([
        ('chat/', ChatConsumer),
    ]),
]