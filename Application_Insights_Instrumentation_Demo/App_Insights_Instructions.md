# Instructions for Instrumenting Application Insights

## Create and Setup the Application
In the cloud shell run this command to create a sample application and change to its directory:
```
dotnet new mvc -o demowebapp
cd ./demowebapp
```

In the clouds shell run this command to add the instrumentation SDK for Application Insights to our app:
```
dotnet add package Microsoft.ApplicationInsights.AspNetCore
```

Initialize Application Insights SDK
Next, we need to initialize the Application Insights SDK by calling the `UseApplicationInsights()` method in our Program.cs file. Start by opening up the code editor inside of the cloud shell by running,
```
code .
```
Then, make sure to add the method shown in our code below. Ensure to save as you move through the editor.
```
public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
WebHost.CreateDefaultBuilder(args)
    .UseStartup<Startup>()
    .UseApplicationInsights(); // Add this line to call the method
```

Instrument Telemetry Button and Actions
Next, we need to instrument the application itself for telemetry events and metrics, by adding this code to the bottom of Views/Home/Index.cshtml to add a Like button to our web app:
```
<div>
    @using (Html.BeginForm("Like","Home"))
    {
        <input type="submit" value="Like" />
        <div>@ViewBag.Message</div>
    }  
</div>
```

Next, we will need to add an action that will act upon the event of a click on our “Like” button. Add the following code to Controllers/HomeControllers.cs to add the action that will run as a response to our “Like” button:
```
[HttpPost]
public ActionResult Like(string button)
{
    ViewBag.Message = "Thank you for your response";
    return View("Index");
}
```


Next, create a `TelemetryClient` field named `aiClient` by adding the following code to the top of our HomeController class:
```
private TelemetryClient aiClient;
```

Next we add a constructor to the HomeController class that accepts a `TelemetryClient` object and assigns it to the `aiClient` field below the line we just added:
```
public HomeController(TelemetryClient aiClient)
{
    this.aiClient = aiClient;
}
```

Next, we add the following use line to the top of this file to enable it to use the instrumentation package.
```
using Microsoft.ApplicationInsights;
```
Deploy Application to App Service
Next we need to save and close our editor and build the application by running the below command in our cloud shell:
```
dotnet publish -o pub
cd pub
zip -r site.zip *
```

Now we can run the following Azure CLI command to deploy our application to our App Service.
Note: Make sure to sub in your values denoted by <> (e.g. <AppServiceName> replaced with “DemoApp”)
```
az webapp deployment source config-zip \
    --src site.zip \
    --resource-group 1-be218f69-playground-sandbox \
    --name ccaidemoapp

```
