class Job {
  final String id;
  final String title;
  final String category;
  final String subCategory;
  final String location;
  final double minSalary;
  final double maxSalary;
  final String description;
  final String company;
  final DateTime postedDate;
  final List<String> requirements;

  Job({
    required this.id,
    required this.title,
    required this.category,
    required this.subCategory,
    required this.location,
    required this.minSalary,
    required this.maxSalary,
    required this.description,
    required this.company,
    required this.postedDate,
    required this.requirements,
  });

  bool matchesFilter(JobFilter filter) {
    if (filter.searchQuery.isNotEmpty) {
      final query = filter.searchQuery.toLowerCase();
      if (!title.toLowerCase().contains(query) &&
          !company.toLowerCase().contains(query) &&
          !description.toLowerCase().contains(query)) {
        return false;
      }
    }

    if (filter.category != null && category != filter.category) {
      return false;
    }

    if (filter.subCategory != null && subCategory != filter.subCategory) {
      return false;
    }

    if (filter.location != null && location != filter.location) {
      return false;
    }

    if (filter.minSalary != null && minSalary < filter.minSalary!) {
      return false;
    }

    if (filter.maxSalary != null && maxSalary > filter.maxSalary!) {
      return false;
    }

    return true;
  }
}

class JobFilter {
  String searchQuery;
  String? category;
  String? subCategory;
  String? location;
  double? minSalary;
  double? maxSalary;

  JobFilter({
    this.searchQuery = '',
    this.category,
    this.subCategory,
    this.location,
    this.minSalary,
    this.maxSalary,
  });

  void reset() {
    searchQuery = '';
    category = null;
    subCategory = null;
    location = null;
    minSalary = null;
    maxSalary = null;
  }
}
