구글 맵 api 연동을 위해 필요한 요소 입니다.

```
<meta-data
            android:name="com.google.android.geo.API_KEY"
            android:value="YOUR_API_KEY" />
```
를 AndroidManifest.xml의  </activity>와 </application> 태그 사이에 넣어주세요

또한 android/app/src/build.gradle에서
```
defaultConfig{
  minSdkVersion 20
}
```
minSdkVersion 20을 추가해주세요
