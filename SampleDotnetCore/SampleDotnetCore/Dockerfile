FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src

RUN dotnet --info

COPY SampleDotnetCore/SampleDotnetCore.csproj SampleDotnetCore/
RUN dotnet restore SampleDotnetCore/SampleDotnetCore.csproj
COPY . .
WORKDIR /src/SampleDotnetCore
RUN dotnet publish SampleDotnetCore.csproj -c Release -o /app

#WORKDIR /app
#COPY --from=build /app .
#ENTRYPOINT ["dotnet", "SampleDotnetCore.dll"]
