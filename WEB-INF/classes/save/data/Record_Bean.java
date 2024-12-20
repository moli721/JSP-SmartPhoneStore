package save.data;

public class Record_Bean {
   private String[][] tableRecord;
   private int currentPage = 1;
   private int pageSize = 5;
   private int totalPages = 1;

   public void setTableRecord(String[][] record) {
      this.tableRecord = record;
   }

   public String[][] getTableRecord() {
      System.out.println("获取tableRecord: " + (tableRecord != null ? tableRecord.length : "null"));
      return tableRecord;
   }

   public void setCurrentPage(int page) {
      this.currentPage = page;
   }

   public int getCurrentPage() {
      return currentPage;
   }

   public void setPageSize(int size) {
      this.pageSize = size;
   }

   public int getPageSize() {
      return pageSize;
   }

   public void setTotalPages(int pages) {
      this.totalPages = pages;
   }

   public int getTotalPages() {
      return totalPages;
   }

   public String[][] getCurrentPageData() {
      if (tableRecord == null)
         return null;

      int start = (currentPage - 1) * pageSize;
      int end = Math.min(start + pageSize, tableRecord.length);
      int size = end - start;

      String[][] currentData = new String[size][tableRecord[0].length];
      for (int i = 0; i < size; i++) {
         System.arraycopy(tableRecord[start + i], 0,
               currentData[i], 0, tableRecord[0].length);
      }
      return currentData;
   }
}
