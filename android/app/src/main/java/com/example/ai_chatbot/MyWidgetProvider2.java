package com.example.ai_chatbot;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.widget.RemoteViews;

public class MyWidgetProvider2 extends AppWidgetProvider {

  @Override
  public void onUpdate(
    Context context,
    AppWidgetManager appWidgetManager,
    int[] appWidgetIds
  ) {
    // Loop through all AppWidgetIds for the widgets on the device
    for (int appWidgetId : appWidgetIds) {
      // Create an Intent to launch the app
      Intent intent = new Intent(context, MainActivity.class);

      // Create PendingIntent with FLAG_IMMUTABLE
      PendingIntent pendingIntent = PendingIntent.getActivity(
        context,
        0,
        intent,
        PendingIntent.FLAG_IMMUTABLE
      );

      // Get the layout for the App Widget and attach click listeners
      RemoteViews views = new RemoteViews(
        context.getPackageName(),
        R.layout.widget_layout_2
      );
      views.setOnClickPendingIntent(R.id.open_app_button, pendingIntent);
      Context appContext = context.getApplicationContext();
      // Set the text to show the latest message from SharedPreferences
      String latestMessage = appContext
        .getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
        .getString("flutter.latest_message", "No message");
      System.out.println("onUpdate called 1" + latestMessage);
      views.setTextViewText(R.id.widget_latest_message, latestMessage);
      appWidgetManager.updateAppWidget(appWidgetId, views);
    }
  }
}
