FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src

RUN dotnet --info

COPY SampleDotnetCore/SampleDotnetCore.csproj SampleDotnetCore/
RUN dotnet restore SampleDotnetCore/SampleDotnetCore.csproj
COPY . .
WORKDIR /src/SampleDotnetCore
RUN dotnet publish SampleDotnetCore.csproj -c Release -o /app -f netcoreapp2.1 -r rhel.7.4-x64 --self-contained false /p:MicrosoftNETPlatformLibrary=Microsoft.NETCore.App

#WORKDIR /app
#COPY --from=build /app .
#ENTRYPOINT ["dotnet", "SampleDotnetCore.dll"]
