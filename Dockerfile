# gebruik microsoft image
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS RISE
#stel dit in als standaard map in de container (alles wordt hier uitgevoerd)
WORKDIR /src
# kopieer repo naar map in container
COPY . .
# tijdens het bouwen wordt dotnet gecompileerd geeft het aan wat gebouwd moet worden en slaat alles op in /app/publish
RUN dotnet publish "src/Rise.Server/Rise.Server.csproj" -c Release -o /app/publish
# nieuwe fase (zware sdk wordt weggegooid)
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
# stelt dir in 
WORKDIR /app
# haalt alles uit vorige fase op
COPY --from=RISE /app/publish .
#variabele instellen (binnenin luisteren naar 8080)
ENV ASPNETCORE_URLS=http://+:8080
# geeft aan welke poort intern gebruikt wordt
EXPOSE 8080
# zorgt dat dotnet rise.server.Dll automatisch wordt uitgevoerd
ENTRYPOINT ["dotnet", "Rise.Server.dll"]