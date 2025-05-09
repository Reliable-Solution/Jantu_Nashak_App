# Razorpay Rules
-keep class com.razorpay.** { *; }
-keep class com.google.android.apps.nbu.paisa.inapp.client.api.** { *; }

# Google Pay SDK Rules
-keep class com.google.android.gms.wallet.** { *; }
-keep class com.google.android.gms.common.** { *; }

# Annotation Rules
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }
-keep @proguard.annotation.Keep class *
-keepclassmembers @proguard.annotation.KeepClassMembers class *
