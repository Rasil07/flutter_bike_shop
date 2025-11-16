abstract class BikesRouteNames {
  static const list = 'bikes:list';
  static const detail = 'bikes:detail';
  static const create = 'bikes:create';
}

/// Paths (single source of truth)
const bikesListPath = '/bikes';
const bikeCreatePath = '/bikes/new';
const bikeDetailPath = '/bikes/:id';
