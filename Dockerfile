FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

# Install wget
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Download GraphHopper
RUN wget -q https://github.com/graphhopper/graphhopper/releases/download/11.0/graphhopper-web-11.0.jar

# Download Turkmenistan OSM data
RUN wget -q https://download.geofabrik.de/asia/turkmenistan-latest.osm.pbf

# Copy config
COPY config.yml .

# Pre-build graph (will happen on first run)
EXPOSE 8989

CMD ["java", "-Xmx512m", "-Xms256m", "-jar", "graphhopper-web-11.0.jar", "server", "config.yml"]
