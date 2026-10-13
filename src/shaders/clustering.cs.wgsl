// TODO-2: implement the light clustering compute shader
@group(${bindGroup_scene}) @binding(0) var<uniform> camera: CameraUniforms;
@group(${bindGroup_scene}) @binding(1) var<storage, read> lightSet: LightSet;
@group(${bindGroup_scene}) @binding(2) var<storage, read_write> clusterSet: ClusterSet;

// ------------------------------------
// Calculating cluster bounds:
// ------------------------------------
// For each cluster (X, Y, Z):
//     - Calculate the screen-space bounds for this cluster in 2D (XY).
//     - Calculate the depth bounds for this cluster in Z (near and far planes).
//     - Convert these screen and depth bounds into view-space coordinates.
//     - Store the computed bounding box (AABB) for the cluster.
fn computeClusterBounds(clusterId: vec3u) -> ClusterBounds {
    // NCHORTEK TODO
    var bounds: ClusterBounds;
    bounds.minValues = vec3f(0.0);
    bounds.maxValues = vec3f(0.0);
    return bounds;
}

// ------------------------------------
// Assigning lights to clusters:
// ------------------------------------
// For each cluster:
//     - Initialize a counter for the number of lights in this cluster.

//     For each light:
//         - Check if the light intersects with the cluster’s bounding box (AABB).
//         - If it does, add the light to the cluster's light list.
//         - Stop adding lights if the maximum number of lights is reached.

//     - Store the number of lights assigned to this cluster.
@compute
@workgroup_size(${clusteringWorkgroupSizeX}, ${clusteringWorkgroupSizeY}, ${clusteringWorkgroupSizeZ})
fn assignLightsToClusters(@builtin(global_invocation_id) global_id: vec3u) {
    if (any(global_id >= clusterSet.gridDims)) {
        return;
    }

    let bounds: ClusterBounds = computeClusterBounds(global_id);

    // Assign lights to the cluster
    let flatClusterId = global_id.x
        + global_id.y * clusterSet.gridDims.x
        + global_id.z * clusterSet.gridDims.x * clusterSet.gridDims.y;
}